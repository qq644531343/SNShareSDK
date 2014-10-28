
/*!
 *  @brief  工具类，提供分享的辅助方法
 */

#import <Foundation/Foundation.h>
#import "SNShareHeaders.h"

@interface SNShareTool : NSObject

/*!
 *  @brief  检查内容数据源
 *  @param  model
 *  @return 正确时返回nil，否则返回error
 */
+(NSError *)checkDataModel:(SNShareModel *)model;

/*!
 *  @brief  解析分享结果
 *  @param errCode 分享返回码
 *  @return 返回对应的明文字符串
 */
+(NSString *)parseResponseCode:(VDShareErrCode)errCode;

/*!
 *  @brief  根据字符串解析出对应的SNShareDest枚举值
 */
+(SNShareDestination)getShareDest:(NSString *)dest;

@end
