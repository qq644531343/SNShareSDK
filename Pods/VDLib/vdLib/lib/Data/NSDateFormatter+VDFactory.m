//
//  NSDateFormatter+Factory.m
//  vdLib
//
//  Created by zhouchen on 14-9-19.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#import "NSDateFormatter+VDFactory.h"

@implementation NSDateFormatter (VDFactory)

+ (NSDateFormatter *)formatterWithFormat:(NSString *)format
{
    static NSMutableDictionary *dictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dictionary = [NSMutableDictionary dictionary];
    });
    
    NSDateFormatter *dateFormat = [dictionary objectForKey:format];
    if (! dateFormat) {
        dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:format];
        [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
        [dateFormat setLocale:[NSLocale systemLocale]];
        [dictionary setObject:dateFormat forKey:format];
    }
    return dateFormat;
}
@end