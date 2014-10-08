
/*!
 @header MathematicFunction.h
 @abstract  math工具
 @author    zhouchen3@staff.sina.com.cn
 */

#import <Foundation/Foundation.h>

@interface VDMathematicFunction : NSObject

/*!
 计算文字字符长度
 */
+ (NSUInteger)MBlogCountWords:(NSString *)text;

/*!
 随机正态分布
 */
+ (double)Norm_rand:(double)miu sigma2:(double)sigma2;

/*!
 判断是否为整形
 */
+ (BOOL)isPureInt:(NSString*)string;

/*!
 判断是否为浮点形
 */
+ (BOOL)isPureFloat:(NSString*)string;

/*!
 格式化TB,GB,MB,KB,Bytes
 */
+ (NSString *)sizeFormat:(long long)bytes;

@end
