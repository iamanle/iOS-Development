//
//  AS4SegmentViewController.h
//  Assignment4
//
//  Created by An Le on 10/18/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AS4SegmentViewController : UIViewController
<UIActionSheetDelegate, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

- (IBAction)segmentControl:(UISegmentedControl *)sender;
- (IBAction)switchOn:(UISwitch *)sender;
- (IBAction)pressButton:(UIButton *)sender;

@end
