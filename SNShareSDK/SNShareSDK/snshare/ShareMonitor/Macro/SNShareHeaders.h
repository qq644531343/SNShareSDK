//
//  SNShareHeaders.h
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#ifndef SNShareSDK_SNShareHeaders_h
#define SNShareSDK_SNShareHeaders_h

/*!
 *  @brief  分享类型
 */
typedef enum SNShareType
{
    SNShareTypeUnknown,
    SNShareTypeNomarl,      //普通模式
    SNShareTypeVideo,       //视频模式
    SNShareTypeAudio        //音频模式
    
}SNShareType;

/*!
 *  @brief  分享渠道
 */
typedef enum SNShareDestination
{
    SNShareDestinationUnknown,
    SNShareDestinationQQFriend,         //QQ好友
    SNShareDestinationQQZone,           //QQ空间
    SNShareDestinationWeixinFriend,     //微信好友
    SNShareDestinationWeixinMoments,    //微信朋友圈
    SNShareDestinationWeibo             //新浪微博
}SNShareDestination;

#import "VDShareGlobal.h"
#import "VDShareConfig.h"

#import "SNShareModel.h"
#import "SNShareManager.h"
#import "SNShareTool.h"

#import "SNShareWindow.h"
#import "SNShareView.h"

#import "SNShareDelegate.h"

/*!
 *  @brief 分享初始化
 */
#define SNSInit {[[SNShareManager sharedSNShareManager] shareConditionInit];}

/*!
 *  @brief 供AppDelegate回调
 */
#define SNSHandle(app,url) {[[SNShareManager sharedSNShareManager] handleOpenUrl:app url:url];}

/*!
 *  @brief  显示分享及设置代理
 */
#define SNShareShow(delegate) {[[SNShareWindow sharedSNShareWindow] showWindowWithDelegate:delegate];}

#endif
