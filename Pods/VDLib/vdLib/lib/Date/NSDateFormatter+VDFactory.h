
/*!
 @header         NSDateFormatter+VDFactory.h
 @abstract       统一在这里获取NSDateFormatter对象,避免重复创建耗费资源
 @author         zhouchen3@staff.sina.com.cn
 */

#import <Foundation/Foundation.h>

@interface NSDateFormatter (VDFactory)

/*!
 获取NSDateFormatter
 @param format 日期格式
 @return DateFormatter
 */
+ (NSDateFormatter *)formatterWithFormat:(NSString *)format;

@end
