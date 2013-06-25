//
//  OMPinCodeView.h
//  OMPinCodeViewExample
//
//  Created by Konstantin Chernuho on 6/3/13.
//  Copyright (c) 2013 EffectiveSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMPinCodeView : UIControl<UIKeyInput,UITextInputTraits>
{
    BOOL _isSecure;
    NSString *_text;
    UIFont *_font;
    UIColor *_textColor;
    NSUInteger _symbolsNumber;
    CGFloat _symbolViewInterval;
}

@property (nonatomic, retain)   NSString *text;
@property (nonatomic, retain)   UIFont *font;
@property (nonatomic, retain)   UIColor *textColor;
@property (nonatomic, assign)   NSUInteger symbolsNumber;
@property (nonatomic, assign)   CGFloat symbolViewInterval;
@property (nonatomic, assign)   BOOL isSecure;

@end
