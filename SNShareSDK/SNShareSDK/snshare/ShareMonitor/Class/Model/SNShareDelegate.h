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
-(void)SNShareResponse:(VDShareErrCode)errCode;

@end


#endif
