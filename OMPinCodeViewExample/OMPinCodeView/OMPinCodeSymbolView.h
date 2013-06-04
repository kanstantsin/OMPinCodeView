//
//  OMPinCodeSymbolView.h
//  OMPinCodeViewExample
//
//  Created by Konstantin Chernuho on 6/3/13.
//  Copyright (c) 2013 EffectiveSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OMPinCodeSymbolView : UIView
{
    BOOL _hasCharacter;
    unichar _character;
}

@property (nonatomic, retain) UIFont *font;
@property (nonatomic, assign) unichar character;
@property (nonatomic, assign) BOOL isSecure;
@property (nonatomic, retain) UIColor *textColor;

- (void)clear;

@end
