//
//  VDWeiboAppInfoUtil.m
//  VDShare
//
//  Created by zhouchen on 14-4-28.
//  Copyright (c) 2014年 sina.corp. All rights reserved.
//

#import "VDShareAppInfoUtil.h"

@implementation VDShareAppInfoUtil
SYNTHESIZE_SINGLETON_FOR_CLASS(VDShareAppInfoUtil)

- (id)init
{
    if (self = [super init]) {
        //先设置为空，以免出现Crash
        self.mobileQQAppID = @"";
        self.mobileQQAppKey = @"";
        self.weiboAppKey = @"";
        self.weiboAppSecret = @"";
        self.weiboRedirectUrl = @"";
        self.weixinAppKey = @"";
        self.weixinAppID = @"";
    }
    return self;
}


@end
