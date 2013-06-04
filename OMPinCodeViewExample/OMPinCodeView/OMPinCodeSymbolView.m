//
//  OMPinCodeSymbolView.m
//  OMPinCodeViewExample
//
//  Created by Konstantin Chernuho on 6/3/13.
//  Copyright (c) 2013 EffectiveSoft. All rights reserved.
//

#import "OMPinCodeSymbolView.h"
#import <CoreText/CoreText.h>

@implementation OMPinCodeSymbolView

@synthesize character = _character;
@synthesize font;
@synthesize isSecure;
@synthesize textColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc
{
    self.textColor = nil;
    [super dealloc];
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = [self bounds];
    CGRect innerRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height-1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Drawing borders
    
    CGContextSaveGState(context);
    
    [[UIColor blackColor] setStroke];
    CGContextStrokeRect(context, innerRect);
    
    [[UIColor whiteColor] setStroke];
    CGContextMoveToPoint(context, 0, bounds.size.height-0.5);
    CGContextAddLineToPoint(context, bounds.size.width, bounds.size.height-0.5);
    CGContextStrokePath(context);
    
    CGContextRestoreGState(context);
    
    // Drawing inner shadow
    
    CGContextSaveGState(context);
    
    // Create the "visible" path, which will be the shape that gets the inner shadow
    // In this case it's just a rounded rect, but could be as complex as your want
    CGMutablePathRef visiblePath = CGPathCreateMutable();
    CGPathAddRect(visiblePath, NULL, CGRectMake(innerRect.origin.x-3.f, innerRect.origin.y, innerRect.size.width+6.f, innerRect.size.height+6.f));
    
    // Now create a larger rectangle, which we're going to subtract the visible path from
    // and apply a shadow
    CGMutablePathRef path = CGPathCreateMutable();
    //(when drawing the shadow for a path whichs bounding box is not known pass "CGPathGetPathBoundingBox(visiblePath)" instead of "bounds" in the following line:)
    //-42 cuould just be any offset > 0
    CGPathAddRect(path, NULL, CGRectInset(bounds, -20, -20));
    
    // Add the visible path (so that it gets subtracted for the shadow)
    CGPathAddPath(path, NULL, visiblePath);
    CGPathCloseSubpath(path);
    
    // Add the visible paths as the clipping path to the context
    CGContextAddPath(context, visiblePath);
    CGContextClip(context);
    
    
    // Now setup the shadow properties on the context
    UIColor *aColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.f];
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 10.0f, [aColor CGColor]);
    
    // Now fill the rectangle, so the shadow gets drawn
    [aColor setFill];
    CGContextAddPath(context, path);
    CGContextEOFillPath(context);
    
    // Release the paths
    CGPathRelease(path);
    CGPathRelease(visiblePath);
    
    CGContextRestoreGState(context);
    
    // Drawing text
    
    if(_hasCharacter == NO)
        return;
    
    CGContextSetFillColorWithColor(context, [self.textColor CGColor]);
    
    if(self.isSecure == YES)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextMoveToPoint(context, rect.size.width/2, rect.size.height/2);
        CGFloat minSize = fminf(rect.size.width, rect.size.height);
        CGFloat circleRadius = minSize/2.f;
        CGContextFillEllipseInRect(context, CGRectMake((rect.size.width - circleRadius)/2, (rect.size.height - circleRadius)/2, circleRadius, circleRadius));
    }
    else
    {
        NSString *charString = [NSString stringWithFormat:@"%C",_character];
        
        CGSize stringSize = [charString sizeWithFont:self.font constrainedToSize:rect.size];
        CGRect drawRect = CGRectMake((rect.size.width-stringSize.width)/2, (rect.size.height-stringSize.height)/2, stringSize.width, stringSize.height);
        
        [charString drawInRect:drawRect withFont:font];
    }
}

#pragma mark - Public

- (void)setCharacter:(unichar)character
{
    _character = character;
    _hasCharacter = YES;
}

- (void)clear
{
    _hasCharacter = NO;
}

@end
