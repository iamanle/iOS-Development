//
//  NSDate+CurrentUTCDate.m
//  Assignment 2
//
//  Created by An Le on 9/5/13.
//  Copyright (c) 2013 An Le. All rights reserved.
//

#import "NSDate+CurrentUTCDate.h"

@implementation NSDate (CurrentUTCDate)
- (NSDate *)now{
    NSDate* sourceDate = [NSDate date];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:sourceDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:sourceDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate* destinationDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:sourceDate];
    
    return destinationDate;
}

- (NSInteger)yearsBetween:(NSDate *)input_date{
    NSDate *now = [NSDate date];
    NSDateComponents *ageComponents = [[NSCalendar currentCalendar]
                                       components:NSYearCalendarUnit
                                       fromDate:input_date
                                       toDate:now
                                       options:0];
    return [ageComponents year];
}
@end
