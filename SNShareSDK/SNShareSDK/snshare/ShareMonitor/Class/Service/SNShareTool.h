
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

@end
