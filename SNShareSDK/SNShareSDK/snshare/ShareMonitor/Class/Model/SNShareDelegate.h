//
//  SNShareDelegate.h
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#ifndef SNShareSDK_SNShareDelegate_h
#define SNShareSDK_SNShareDelegate_h

#import "SNShareModel.h"

@class SNShareResModel;

/*!
 *  @brief  分享数据及返回协议
 */
@protocol SNShareDelegate <NSObject>

/*!
 *  @brief  数据源
 *  @return 经过check的正确数据源
 */
-(SNShareModel *)SNShareDataSource;

/*!
 *  @brief  分享结果
 *  @param errCode 参看 VDShareErrCode
 */
-(void)SNShareResponse:(VDShareErrCode)errCode Msg:(NSString *)msg;

@end

/////////////////////////////////////

/*!
 *  @brief  UI与Manager点击响应协议
 */
@protocol SNShareActionDelegate <NSObject>

/*!
 *  @brief  分享点击事件
 *  @param view 按钮
 *  @param view 分享View
 *  @param res  资源数据
 */
-(void)SNShareClickInView:(UIView *)view parentView:(UIView *)pview resModel:(SNShareResModel *)res;

@end


#endif
