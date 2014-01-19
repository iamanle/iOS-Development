//
//  NSString+DateConverter.m
//  Assignment 2
//
//  Created by An Le on 9/5/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "NSString+DateConverter.h"

@implementation NSString (DateConverter)
- (NSDate *)asDate:(NSString *)string{
    NSDateFormatter *convert_date = [[NSDateFormatter alloc] init];
    [convert_date setDateFormat:@"MM/dd/yyyy"];
    return [convert_date dateFromString:string];
}
@end
