//
//  NSDate+Utils.m
//  ChallengeApp
//
//  Created by MCS on 9/9/15.
//  Copyright (c) 2015 MCS. All rights reserved.
//

#import "NSDate+Utils.h"

@implementation NSDate (Utils)
-(NSString *)shortFormattedDateString{
    NSLocale *dateLocale = [NSLocale currentLocale];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:dateLocale];
    dateFormatter.dateStyle = NSDateFormatterShortStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSString * dateStr = [dateFormatter stringFromDate:self];
    return  dateStr;
    
}
@end
