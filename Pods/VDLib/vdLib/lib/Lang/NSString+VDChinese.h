
/*!
 @header         NSString+VDChinese
 @abstract       判断字符串类型
 */

#import <Foundation/Foundation.h>

@interface NSString (BSSTRING_EXTEND)
+ (NSString *)stringWithUTF8String:(const char *)utf8String defaultValue:(NSString *)defaultValue;

/*!
 判断character是否是汉字字符
 
 @param character 待判断的字符
 
 @return BOOL
 */
+ (BOOL)isChineseCharacter:(unichar)character;

/*!
 判断该NSString是否是汉字字符串
 
 @return BOOL
 */
- (BOOL)isChineseString;

/*!
 判断是否为有效Email地址
 
 @return BOOL
 */
- (BOOL)isValidateEmail;

@end


