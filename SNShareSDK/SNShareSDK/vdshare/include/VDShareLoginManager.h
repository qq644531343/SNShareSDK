//
//  登录管理类
//
//  Created by sunxiao on 14-3-3.
//  Copyright (c) 2014年 sunxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VDWeiboLoginMessage.h"
#import "VDWeiboManager.h"

@interface VDShareLoginManager : NSObject

//@brief appdelegate里面调用此函数将缓冲的数据加载进来
+ (void) registerLogin;

//@brief 得到当前用户信息，可以使用VDWeiboLoginMessage.checkLoginExpire来判断登录是否有效
+ (VDWeiboLoginMessage *) getWeiboLoginMessage;

//@brief 微博登录发起
+ (void) weiboLogin:(id<VDWeiboManagerLoginDelegate>) delegate;

//@brief 微博退出发起
+ (void) weiboLoginOut;

@end
