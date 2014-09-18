//
//  VDWeiboAppInfoUtil.h
//  VDShare
//
//  Created by zhouchen on 14-4-28.
//  Copyright (c) 2014年 sina.corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDShareSynthesizeSingleton.h"

@interface VDShareAppInfoUtil : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDShareAppInfoUtil)

//微博部分
@property (nonatomic, copy) NSString *weiboAppKey;
@property (nonatomic, copy) NSString *weiboAppSecret;
@property (nonatomic, copy) NSString *weiboRedirectUrl;

//手Q部分
@property (nonatomic,copy) NSString *mobileQQAppID;
@property (nonatomic,copy) NSString *mobileQQAppKey;
//微信部分
@property (nonatomic,copy) NSString *weixinAppID;
@property (nonatomic,copy) NSString *weixinAppKey;

@end
