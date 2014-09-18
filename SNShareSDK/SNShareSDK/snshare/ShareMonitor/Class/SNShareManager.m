//
//  SNShareManger.m
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "SNShareManager.h"
#import "SNShareHeaders.h"

@implementation SNShareManager

static SNShareManager *instance = nil;
+(SNShareManager *)sharedSNShareManager
{
    if (instance == nil) {
        @synchronized(instance){
            if (instance == nil) {
                instance = [[SNShareManager alloc] init];
            }
        }
    }
    return instance;
}

#pragma mark - Init

-(void)shareConditionInit
{
     [self performSelector:@selector(shareInit) withObject:nil afterDelay:0.5];
}

-(void)shareInit
{
    //分享初始化
    [self registerShareConfig];
    [[VDShareManager sharedInstance] registerApp];
}

//设置相关的分享appkey等信息
- (void) registerShareConfig
{
    [VDShareAppInfoUtil sharedInstance].weiboAppKey = kWeiboAppKey;
    [VDShareAppInfoUtil sharedInstance].weiboAppSecret = kWeiboAppSecret;
    [VDShareAppInfoUtil sharedInstance].weiboRedirectUrl = kWeiboRedirectURI;
    
    [VDShareAppInfoUtil sharedInstance].weixinAppID = KVDWXAppID;
    [VDShareAppInfoUtil sharedInstance].weixinAppKey = kVDWXAppKey;
    
    [VDShareAppInfoUtil sharedInstance].mobileQQAppID = kVDQQAppID;
    [VDShareAppInfoUtil sharedInstance].mobileQQAppKey = kVDQQAppKey;
}

#pragma mark - share Handle

-(BOOL)handleOpenUrl:(UIApplication *)app url:(NSURL *)url
{
    [[VDShareManager sharedInstance] handleOpenUrl:app url:url];
    return YES;
}

@end
