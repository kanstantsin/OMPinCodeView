//
//  ViewController.m
//  OMPinCodeViewExample
//
//  Created by Konstantin Chernuho on 6/3/13.
//  Copyright (c) 2013 EffectiveSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize pinCodeView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.pinCodeView.isSecure = YES;
    self.pinCodeView.symbolsNumber = 3;
    self.pinCodeView.font = [UIFont boldSystemFontOfSize:48.f];
    self.pinCodeView.textColor = [UIColor redColor];
    
    self.pinCodeView.text = @"001";
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.pinCodeView = nil;
    
    [super dealloc];
}

- (IBAction)pinCodeViewValueChanged:(id)sender
{
    NSLog(@"%@",self.pinCodeView.text);
}

@end
