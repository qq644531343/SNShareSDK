//
//  CShareHelper.h
//  sinavideo
//
//  Created by sunxiao on 14-2-20.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark 去向部分定义
#define kShareActionTitleGupiaoMoments      @"股票圈"
#define kShareActionTitleWeiXin             @"微信"
#define kShareActionTitleWeiXinMoments      @"朋友圈"
#define kShareActionTitleQzone              @"QQ空间"
#define kShareActionTitleQQ                 @"QQ"
#define kShareActionTitleTencentWb          @"腾讯微博"
#define kShareActionTitleSinaWeiBo          @"新浪微博"
#define kShareActionTitleEmail              @"邮件"
#define kShareActionTitleMessage            @"短信"
#define kShareActionTitleCancel             @"取消分享"

#define __VDSHAREHELPERWEIXIN @"weixin"
#define __VDSHAREHELPERQQ @"qq"
#define __VDSHAREHELPERWEIBO @"weibo"

#define __VDSHAREHELPERWEIXINOBNAME @"VDSHAREHELPERWEIXINOBNAME"

enum
{
    eActionSheetShareQzone,         //分享到 空间
	eActionSheetShareWeixin,        //分享到 微信好友
    eActionSheetShareWeixinMoments, //分享到 微信朋友圈
    eActionSheetShareShouQQ,        //分享到 手Q
	eActionSheetShareSinaWeibo,     //分享到 新浪
	eActionSheetShareCancel
};

typedef NSUInteger TActionSheetIndex;

#pragma mark 返回部分的定义
#define CWXURLVIDEODETAIL  @"sinavideodetail"
/**
 1、点击下面“打开新浪视频，查看详情”
 sinavideo://detail/[视频url](urlencode)
 **/

typedef enum
{
    //在此添加相应的应用部分
    eSinaVideoDetail,
    //未知类型
    eUnknow,
} EWXUrlType;


//访问app
typedef enum {
    eTencentWeixin,  //微信、朋友圈
    eTencentQQ,      //手机QQ
    eTencentQzone,   //QQ空间
    eSinaWeibo,      //新浪微博
    eUnknownApp,
} EGuestApp;

@interface VDShareHelper : NSObject

+ (EGuestApp) getAppTypeFromUrl:(NSURL *) url;
+ (NSString *) getPureUrlWithUrl:(NSString *)url  guestAppType:(EGuestApp) guestAppType;

@end
