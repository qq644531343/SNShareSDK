//
//  VDUtilsTime.m
//  vdLib
//
//  Created by Yuan on 14-10-8.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#import "VDUtilsTime.h"

@implementation VDUtilsTime

+ (NSString *)convertDataForDetailComment:(NSDate *)tempDate
{
    NSDate *now = [NSDate date];
    
    NSTimeInterval temp = [now timeIntervalSince1970] - [tempDate timeIntervalSince1970];
    
    if (temp < -60 * 5 )
    {
        return nil;
    }
    else if (temp <= 60)
    {
        return @"刚刚";
    }
    else if(temp <= 60 * 60)
    {
        return [NSString stringWithFormat:@"%.0f分钟前", temp / 60];
    }
    else if (temp <= 24 * 60 * 60)
    {
        return [NSString stringWithFormat:@"%.0f小时前", temp / (60 * 60)];
    }
    else
    {
        return [NSString stringWithFormat:@"%@月%@日",
                [self.class monthOfDate:tempDate],
                [self.class dayOfDate:tempDate]];
    }
    return nil;
}

// 取出月
+ (NSString *)monthOfDate:(NSDate *)date
{
    if (date == nil || [date isEqual:[NSNull null]]) return @"";
    
    unsigned units  = NSMonthCalendarUnit;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [cal components:units fromDate:date];
    NSInteger month = [comp month];
    
    return [NSString stringWithFormat:@"%ld", (long)month];
}

// 取出日
+ (NSString *)dayOfDate:(NSDate *)date
{
    if (date == nil || [date isEqual:[NSNull null]]) return @"";
    
    unsigned units  = NSDayCalendarUnit;
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comp = [cal components:units fromDate:date];
    NSInteger day = [comp day];
    
    return [NSString stringWithFormat:@"%ld", (long)day];
}


@end
