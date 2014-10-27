//
//  SNShareManger.h
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNShareHeaders.h"

@class SNShareModel;

@interface SNShareManager : NSObject<VDShareManagerDelegate>

+(SNShareManager *)sharedSNShareManager;

/*!
 *  @brief 分享环境初始化
 */
-(void)shareConditionInit;

/*!
 *  @brief App分享回调
 */
- (BOOL) handleOpenUrl:(UIApplication *)app url:(NSURL *)url;

#pragma mark - Content
/*!
 *  @brief  存放分享的初始化素材
 */
@property (nonatomic,strong) NSArray *resourceArray;


-(void)test;

@end
