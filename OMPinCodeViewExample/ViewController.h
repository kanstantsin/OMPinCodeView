//
//  ViewController.h
//  OMPinCodeViewExample
//
//  Created by Konstantin Chernuho on 6/3/13.
//  Copyright (c) 2013 EffectiveSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMPinCodeView.h"

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutlet OMPinCodeView *pinCodeView;

- (IBAction)pinCodeViewValueChanged:(id)sender;

@end
