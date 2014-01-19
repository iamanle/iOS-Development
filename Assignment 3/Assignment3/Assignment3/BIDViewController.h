//
//  BIDViewController.h
//  Assignment3
//
//  Created by An Le on 9/23/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BIDViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *redField;
@property (weak, nonatomic) IBOutlet UITextField *greenField;
@property (weak, nonatomic) IBOutlet UITextField *blueField;
@property (weak, nonatomic) IBOutlet UIView *colorView;

- (IBAction)changeColor:(UIButton *)sender;
- (IBAction)leaveTextField:(id)sender;
- (IBAction)backgroundTap:(id)sender;

// Trying
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
@end
