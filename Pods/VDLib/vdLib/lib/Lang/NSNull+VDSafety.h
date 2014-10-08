
/*!
 @header         NSNull+VDSafety.h
 @abstract       NSNull安全Category
                 会截获NSNull doesNotRecognizeSelector的crash 
                 防止程序崩溃并XLog warn
 @author         yuanliang@staff.sina.com.cn
 */

#import <Foundation/Foundation.h>

@interface NSNull (VDSafety)

@end
