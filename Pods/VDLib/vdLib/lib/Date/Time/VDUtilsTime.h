
/*!
 @header VDUtilsTime.h
 @abstract 时间转换
 */

#import <Foundation/Foundation.h>

@interface VDUtilsTime : NSObject

/*!
 过去时间点对比当前时间
 @param tempDate 过去时间点
 @return NSString :"刚刚"、"n分钟前"、"n小时前"、"x月y日"  输入为空时return nil
 */
+ (NSString *)convertDataForDetailComment:(NSDate *)tempDate;

/*!
 取出date中月份
 @param date
 @return 例: "1"、"2"、"3"、"10"等
 */
+ (NSString *)monthOfDate:(NSDate *)date;

/*!
 取出date中日
 @param date
 @return 例: "1"、"12"、"31"等
 */
+ (NSString *)dayOfDate:(NSDate *)date;
@end
