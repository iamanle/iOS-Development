//
//  AS4SegmentViewController.m
//  Assignment4
//
//  Created by An Le on 10/18/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "AS4SegmentViewController.h"

@interface AS4SegmentViewController ()

@end

@implementation AS4SegmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.switchButton.hidden = NO;
    self.indicator.hidden = NO;
    self.textView.hidden = YES;
    self.button.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentControl:(UISegmentedControl *)sender {
    
    if (sender.selectedSegmentIndex == 0) {
        self.switchButton.hidden = NO;
        self.indicator.hidden = NO;
        self.textView.hidden = YES;
        self.button.hidden = YES;
    }
    
    if (sender.selectedSegmentIndex == 1) {
        self.switchButton.hidden = YES;
        self.indicator.hidden = YES;
        self.textView.hidden = NO;
        self.button.hidden = YES;
    }
    
    if (sender.selectedSegmentIndex == 2) {
        self.switchButton.hidden = YES;
        self.indicator.hidden = YES;
        self.textView.hidden = YES;
        self.button.hidden = NO;
    }
}

- (IBAction)switchOn:(UISwitch *)sender {
    BOOL setting = sender.isOn;
    if (setting == TRUE) {
        [self.indicator startAnimating];
    } else
        [self.indicator stopAnimating];

}
- (IBAction)pressButton:(UIButton *)sender {
    UIActionSheet *question = [[UIActionSheet alloc]
                               initWithTitle:@"Do you like the iPhone?"
                               delegate:self
                               cancelButtonTitle:@"Nah"
                               destructiveButtonTitle:@"Yes, I love it."
                               otherButtonTitles:nil];
    [question showInView:self.view];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}
@end
