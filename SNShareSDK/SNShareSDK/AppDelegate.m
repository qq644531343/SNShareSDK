//
//  AppDelegate.m
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "AppDelegate.h"
#import "SNShareHeaders.h"

@implementation AppDelegate

#pragma mark - share handle

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    SNSHandle(application,url);
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //分享回调
    SNSHandle(application,url);
    
    return YES;
}

#pragma mark - main

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //分享环境初始化
    SNSInit
    
    return YES;
}


@end
