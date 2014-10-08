//
//  CShareHelper.m
//  sinavideo
//
//  Created by sunxiao on 14-2-20.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#import "VDShareHelper.h"

@implementation VDShareHelper


+ (EGuestApp) getAppTypeFromUrl:(NSURL *) url
{
    EGuestApp ret = eUnknownApp;
    
    NSString *urlStr = [url absoluteString];
    NSUInteger index = 0;
    index = [urlStr rangeOfString:@":"].location;
    NSString *domainName = [urlStr substringToIndex:index];
    if(![domainName isEqualToString:@"sinavideo"])
    {
        //不是sinavideo方式打开的，直接返回就可以了
        return eUnknownApp;
    }
    index = [urlStr rangeOfString:@"?"].location;
    if(index != NSNotFound)
    {
        index = [urlStr rangeOfString:@"app="].location;
        if(index != NSNotFound)
        {
            NSString *appName = [urlStr substringFromIndex:index];
            index = [appName rangeOfString:@"&"].location;
            if(index != NSNotFound)
            {
                appName = [appName substringToIndex:index];
            }
            if([appName isEqualToString:__VDSHAREHELPERWEIBO])
            {
                ret = eSinaWeibo;
            }else if([appName isEqualToString:__VDSHAREHELPERQQ])
            {
                ret = eTencentQQ;
            }else if([appName isEqualToString:__VDSHAREHELPERWEIXIN])
            {
                ret = eTencentWeixin;
            }
        }
    }
    
    return ret;
}


+ (NSString *)getPureUrlWithUrl:(NSString *)url guestAppType:(EGuestApp)guestAppType
{
    NSAssert(url!=nil, @"url is nil");
    NSString *pureUrl = nil;
    NSString *urlSplit = @"?";
    if([url rangeOfString:@"?"].length > 0)
    {
        urlSplit = @"&";
    }
    if(guestAppType == eTencentQQ || guestAppType == eTencentQzone)
    {
        pureUrl = [NSString stringWithFormat:@"%@%@app=%@",url,urlSplit,__VDSHAREHELPERQQ];
    }else if (guestAppType == eTencentWeixin)
    {
        pureUrl = [NSString stringWithFormat:@"%@%@app=%@",url,urlSplit,__VDSHAREHELPERWEIXIN];
    }else if(guestAppType == eSinaWeibo)
    {
        pureUrl = [NSString stringWithFormat:@"%@%@app=%@",url,urlSplit,__VDSHAREHELPERWEIBO];
    }
    return pureUrl;
}

@end
