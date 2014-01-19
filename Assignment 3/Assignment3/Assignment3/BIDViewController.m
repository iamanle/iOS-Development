//
//  BIDViewController.m
//  Assignment3
//
//  Created by An Le on 9/23/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "BIDViewController.h"

@interface BIDViewController ()

@end

@implementation BIDViewController{
    CGPoint lastLocation;
}

- (void)viewDidLoad
{
    //colorView shows black color by default, so there is no need to set it.
    //Load previous values
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *red = [defaults objectForKey:@"restoreRed"];
    NSString *blue = [defaults objectForKey:@"restoreBlue"];
    NSString *green = [defaults objectForKey:@"restoreGreen"];
    
    _redField.text = red;
    _greenField.text = green;
    _blueField.text = blue;
    _colorView.backgroundColor = [[UIColor alloc]initWithRed:[red floatValue]/100
                                                       green:[green floatValue]/100
                                                        blue:[blue floatValue]/100
                                                       alpha:1];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeColor:(UIButton *)sender {
    //Retrive inputs and set background color for colorView
    NSString *red = [_redField text];
    NSString *green = [_greenField text];
    NSString *blue = [_blueField text];
    
    self.colorView.backgroundColor =
    [[UIColor alloc] initWithRed:[red floatValue]/100
                           green:[green floatValue]/100
                            blue:[blue floatValue]/100
                           alpha:1];
    
    //Hide keyboards: By passing in sender as touch action to backgroundTap
    [self backgroundTap:sender];
    
    //Save current values
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:red forKey:@"restoreRed"];
    [defaults setObject:green forKey:@"restoreGreen"];
    [defaults setObject:blue forKey:@"restoreBlue"];
    [defaults synchronize];
    NSLog(@"Data saved");
}

//Hide keyboard when leave textfields
- (IBAction)leaveTextField:(id)sender {
    [sender resignFirstResponder];
}

//Hide keyboard when tap background
- (IBAction)backgroundTap:(id)sender{
    [self.redField resignFirstResponder];
    [self.greenField resignFirstResponder];
    [self.blueField resignFirstResponder];
}

// Trying:
//- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
//    UITouch *touch = [[event allTouches] anyObject];
//    if ([touch.view isEqual: self.view] || touch.view == nil) {
//        return;
//    }
//    
//    lastLocation = [touch locationInView: self.view];
//}
//
//- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
//    UITouch *touch = [[event allTouches] anyObject];
//    if ([touch.view isEqual: self.view]) {
//        return;
//    }
//    
//    CGPoint location = [touch locationInView: self.view];
//    
//    CGFloat xDisplacement = location.x - lastLocation.x;
//    CGFloat yDisplacement = location.y - lastLocation.y;
//    
//    CGRect frame = touch.view.frame;
//    frame.origin.x += xDisplacement;
//    frame.origin.y += yDisplacement;
//    touch.view.frame = frame;
//}
@end
