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

//设置内容数据源
-(NSError *)setDataModel:(SNShareModel *)model type:(SNShareType)atype dest:(SNShareDestination)adest;

-(void)test;

@end
