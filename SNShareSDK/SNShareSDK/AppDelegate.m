//
//  AppDelegate.m
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "AppDelegate.h"

#import "VDShareGlobal.h"
#import "VDShareConfig.h"

@implementation AppDelegate

#pragma mark - share

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [[VDShareManager sharedInstance] handleOpenUrl:application url:url];
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //分享回调
    [[VDShareManager sharedInstance] handleOpenUrl:application url:url];
    return YES;
}

-(void)shareConditionInit
{
    //分享初始化
    [self registerShareConfig];
    [[VDShareManager sharedInstance] registerApp];
    
}

//设置相关的分享appkey等信息
- (void) registerShareConfig
{
    //    [VDShareAppInfoUtil sharedInstance].weiboAppKey = kWeiboAppKey;
    //    [VDShareAppInfoUtil sharedInstance].weiboAppSecret = kWeiboAppSecret;
    //    [VDShareAppInfoUtil sharedInstance].weiboRedirectUrl = kWeiboRedirectURI;
    
    [VDShareAppInfoUtil sharedInstance].weixinAppID = KVDWXAppID;
    [VDShareAppInfoUtil sharedInstance].weixinAppKey = kVDWXAppKey;
    
    //    [VDShareAppInfoUtil sharedInstance].mobileQQAppID = kVDQQAppID;
    //    [VDShareAppInfoUtil sharedInstance].mobileQQAppKey = kVDQQAppKey;
}


#pragma mark - Other

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //分享环境初始化
    [self performSelector:@selector(shareConditionInit) withObject:nil afterDelay:0.5];

    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
