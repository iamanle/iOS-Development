//
//  chatCell.h
//  ShyStudent
//
//  Created by An Le on 11/23/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface chatCell : UITableViewCell{
    IBOutlet UILabel *userLabel;
    IBOutlet UITextView *textString;
    IBOutlet UILabel *timeLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *userLabel;
@property (nonatomic, retain) IBOutlet UITextView *textString;
@property (nonatomic, retain) IBOutlet UILabel *timeLabel;

@end
