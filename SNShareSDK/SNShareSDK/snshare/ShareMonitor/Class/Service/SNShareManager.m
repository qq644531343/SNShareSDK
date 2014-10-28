//
//  SNShareManger.m
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "SNShareManager.h"
#import "SNShareHeaders.h"
#import "SNShareResModel.h"

#import "ALToastView.h"

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
    
    [self loadResource];
    [SNShareWindow sharedSNShareWindow];
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

#pragma mark - data Manager
-(void)loadResource
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"snsres" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    
    NSMutableArray *res = [[NSMutableArray alloc] init];
    for (NSDictionary *item in array) {
        SNShareResModel *model = [[SNShareResModel alloc] init];
        model.title = [item objectForKey:@"title"];
        model.dest = [SNShareTool getShareDest:[item objectForKey:@"dest"]];
        model.img = [item objectForKey:@"img"];
        [res addObject:model];
    }
    _resourceArray = [NSArray arrayWithArray:res];
}

#pragma mark - share Handle

-(BOOL)handleOpenUrl:(UIApplication *)app url:(NSURL *)url
{
    [[VDShareManager sharedInstance] handleOpenUrl:app url:url];
    return YES;
}

#pragma mark - VDShareManagerDelegate

-(void)onShareResponse2:(VDShareErrCode)errCode {
    
    NSString *msg = [SNShareTool parseResponseCode:errCode];
    [ALToastView toastInView:[SNShareWindow sharedSNShareWindow] withText:msg];
    
    id<SNShareDelegate> delegate = [SNShareWindow sharedSNShareWindow].shareDelegate;
    if ([delegate respondsToSelector:@selector(SNShareResponse:Msg:)]) {
        [delegate SNShareResponse:errCode Msg:msg];
    }

}

#pragma mark - SNShareActionDelegate
-(void)SNShareClickInView:(UIView *)view parentView:(UIView *)pview resModel:(SNShareResModel *)res
{
    DLog(@"%@",res.title);
    
    SNShareModel *data = nil;
    id<SNShareDelegate> delegate = [SNShareWindow sharedSNShareWindow].shareDelegate;
    if ([delegate respondsToSelector:@selector(SNShareDataSource)]) {
        data = [delegate SNShareDataSource];
        if ( 0 && data == nil) {
            return;
        }
    }
    
    VDShareParam *params = [SNShareTool getShareParam:data];
    
    if (res.dest == SNShareDestinationWeibo) {
        //[self sinaweiboLoginClicked:btn];
        return;
    }
    
    if (res.dest == SNShareDestinationWeixinFriend) {
        [[VDShareManager sharedInstance] shareToWXWithObject:params delegate:self shareType:eVDWXShareTypeLink messageType:eVDWXMessageTypeMultimedia];
    }
    
    if (res.dest == SNShareDestinationWeixinMoments) {
        
        [[VDShareManager sharedInstance] shareToWXMomentsWithObject:params delegate:self shareType:eVDWXShareTypeLink messageType:eVDWXMessageTypeMultimedia];
        
    }
    
    if (res.dest == SNShareDestinationQQZone) {
        
        [[VDShareManager sharedInstance] shareToQzoneWithObject:params delegate:self messageType:eVDQQMessageTypeNews];
    }
    
    if (res.dest == SNShareDestinationQQFriend) {
        
        [[VDShareManager sharedInstance] shareToShouQQWithObject:params delegate:self messageType:eVDQQMessageTypeNews];
    }

}

@end
