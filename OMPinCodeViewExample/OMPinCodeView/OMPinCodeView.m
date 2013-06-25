//
//  OMPinCodeView.m
//  OMPinCodeViewExample
//
//  Created by Konstantin Chernuho on 6/3/13.
//  Copyright (c) 2013 EffectiveSoft. All rights reserved.
//

#import "OMPinCodeView.h"
#import "OMPinCodeSymbolView.h"
#import <QuartzCore/QuartzCore.h>

@interface OMPinCodeView()

@property (nonatomic, retain) NSMutableArray *symbolViews;

@end

@implementation OMPinCodeView

@synthesize text = _text;
@synthesize font = _font;
@synthesize symbolsNumber = _symbolsNumber;
@synthesize symbolViews;
@synthesize isSecure = _isSecure;
@synthesize textColor = _textColor;
@synthesize symbolViewInterval = _symbolViewInterval;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initDefault];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initDefault];
}

- (void)initDefault
{
    self.text = @"";
    self.font = [UIFont boldSystemFontOfSize:18.f];
    _symbolsNumber = 4;
    
    self.symbolViewInterval = (self.frame.size.width/self.symbolsNumber)*0.2f;
    
    self.symbolViews = [NSMutableArray arrayWithCapacity:self.symbolsNumber];
    
    [self initSymbolViews];
}

- (void)dealloc
{
    self.text = nil;
    self.font = nil;
    self.symbolViews = nil;
    
    [super dealloc];
}

- (void)layoutSubviews
{
    CGSize symbolViewSize = CGSizeMake((self.frame.size.width - (self.symbolsNumber - 1)*self.symbolViewInterval)/self.symbolsNumber, self.frame.size.height);
    
    for(int i=0;i<self.symbolsNumber;i++)
    {
        OMPinCodeSymbolView *symbolView = [self.symbolViews objectAtIndex:i];
        symbolView.frame = CGRectMake(i*(self.symbolViewInterval+symbolViewSize.width), 0, symbolViewSize.width, symbolViewSize.height);
        [symbolView setNeedsDisplay];
    }
}

#pragma mark - Setters

- (void)setSymbolViewInterval:(CGFloat)symbolViewInterval
{
    _symbolViewInterval = symbolViewInterval;
    [self setNeedsLayout];
}

- (void)setSymbolsNumber:(NSUInteger)symbolsNumber
{
    _symbolsNumber = symbolsNumber;
    for(OMPinCodeSymbolView *symbolView in self.symbolViews)
    {
        [symbolView removeFromSuperview];
    }
    [self.symbolViews removeAllObjects];
    [self initSymbolViews];
}

- (void)setText:(NSString *)text
{
    [_text autorelease];
    _text = [text retain];
    
    NSUInteger textLength = [_text length];

    if(textLength > self.symbolsNumber)
    {
        NSLog(@"%@ warning: the text is too long. It will be truncated to %d symbols",[[self class] description],self.symbolsNumber);
        _text = [[_text substringToIndex:self.symbolsNumber] retain];
    }
    
    [self updateSymbolViews];
}

- (void)setIsSecure:(BOOL)isSecure
{
    _isSecure = isSecure;
    for(OMPinCodeSymbolView *symbolView in self.symbolViews)
    {
        symbolView.isSecure = isSecure;
        [symbolView setNeedsDisplay];
    }
}

- (void)setFont:(UIFont *)font
{
    [_font autorelease];
    _font = [font retain];
    for(OMPinCodeSymbolView *symbolView in self.symbolViews)
    {
        symbolView.font = font;
        [symbolView setNeedsDisplay];
    }
}

- (void)setTextColor:(UIColor *)textColor
{
    [_textColor autorelease];
    _textColor = [textColor retain];
    for(OMPinCodeSymbolView *symbolView in self.symbolViews)
    {
        symbolView.textColor = textColor;
        [symbolView setNeedsDisplay];
    }
}

#pragma mark - Private

- (void)initSymbolViews
{
    for(int i=0;i<self.symbolsNumber;i++)
    {
        OMPinCodeSymbolView *symbolView = [[OMPinCodeSymbolView alloc] initWithFrame:CGRectZero];
        [self addSubview:symbolView];
        symbolView.backgroundColor = [UIColor whiteColor];
        symbolView.font = self.font;
        [self.symbolViews addObject:symbolView];
    }
}

- (void)updateSymbolViews
{
    NSUInteger textLength = [self.text length];
    
    for(int i=0;i<textLength;i++)
    {
        OMPinCodeSymbolView *symbolView = [self.symbolViews objectAtIndex:i];
        unichar character = [self.text characterAtIndex:i];
        symbolView.character = character;
        [symbolView setNeedsDisplay];
    }
}

#pragma mark - UIResponder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - Touches

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self becomeFirstResponder];
}

#pragma mark - UIKeyInput

- (BOOL)hasText
{
    if([self.text length] == 0)
        return NO;
    return YES;
}

- (void)insertText:(NSString *)aText
{
    if([self.text length] == self.symbolsNumber)
        return;
    
    self.text = [self.text stringByAppendingString:aText];
    
    [self updateSymbolViews];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

#pragma mark - UITextInputTraits

- (UIKeyboardType)keyboardType
{
    return UIKeyboardTypeNumberPad;
}

- (void)deleteBackward
{
    if([self.text length] == 0)
        return;
    
    self.text = [self.text substringToIndex:[self.text length]-1];
    NSUInteger clearedIndex = [self.text length];
    OMPinCodeSymbolView *symbolView = [self.symbolViews objectAtIndex:clearedIndex];
    [symbolView clear];
    [symbolView setNeedsDisplay];
    
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

@end
