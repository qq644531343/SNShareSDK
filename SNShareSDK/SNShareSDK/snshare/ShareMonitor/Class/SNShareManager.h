//
//  SNShareManger.h
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNShareManager : NSObject

+(SNShareManager *)sharedSNShareManager;

//分享环境初始化
-(void)shareConditionInit;

//分享回调
- (BOOL) handleOpenUrl:(UIApplication *)app url:(NSURL *)url;

@end
