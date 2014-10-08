//
//  getddidsdk.m
//  getddidsdk
//
//  Created by hadn't on 13-8-29.
//  Copyright (c) 2013年 hadn't. All rights reserved.
//

#import "getddidsdk.h"
#include "OpenUDID.h"
#import <UIKit/UIKit.h>

static NSDateFormatter * openUDIDFormatter;

@implementation getddidsdk

+ (NSString *)getUniqueStrByUUID
{

    NSUUID *adId = [[ASIdentifierManager sharedManager] advertisingIdentifier];
                      
    return [adId UUIDString];
}

+ (NSString *)getUniqueStrByOpenUDID
{
    NSString* openUDID = [OpenUDID value];
    return openUDID;
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

+ (NSString *)getTime
{
    NSDate *  senddate=[NSDate date];
    
    if ( nil == openUDIDFormatter )
    {
        openUDIDFormatter = [[NSDateFormatter alloc] init];
        [openUDIDFormatter setDateFormat:@"YYYYMMdd"];
    }
    
    NSString *  locationString=[openUDIDFormatter stringFromDate:senddate];
    
    return locationString;
}

+ (BOOL)CanUseOpenUDID
{
    return ([UIDevice currentDevice].systemVersion.intValue <= 6);
}

+ (NSString *)Did
{
    NSString *device = nil;
    if ([self CanUseOpenUDID])
    {
        device = [self getUniqueStrByOpenUDID];
    }
    else
    {
        device = [self getUniqueStrByUUID];
    }
    return [self md5:device];
}

+ (NSString *)Checkid
{
    return [self md5:[[self Did] stringByAppendingString:[[self getTime] stringByAppendingString:@"hongtaok"]]];
}
/*
 获取open udid 或 adid 然后md5生成 32字符串（暂叫：did）。
 
 对这32位字符（did）做校验。
 
 校验方式： （did + 日期 + 密码）做md5生成32位字符串（暂叫：checkid）
 
 最终的deviceid = did + checkid的后8位（共40位的字符串）
 
 */
+ (NSString *)DeviceId
{
    return [[self Did] stringByAppendingString: [[self Checkid] substringFromIndex:24]];
}

+ (NSString *)oldDeviceId
{
    NSString *device = nil;
    if ([self CanUseOpenUDID])
    {
        device = [self getUniqueStrByOpenUDID];
    }
    else
    {
        device = [self DeviceId];
    }
    return device;
}

@end
