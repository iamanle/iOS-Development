//
//  chatCell.m
//  ShyStudent
//
//  Created by An Le on 11/23/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "chatCell.h"

@implementation chatCell
@synthesize userLabel, timeLabel, textString;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
