/*!
 @header   NSDictionary+VDExtending
 @abstract NSDictionary扩展，用来将简单类型加入到字典中
 */

#import <Foundation/Foundation.h>

/*!
 NSDictionary扩展
 与上面的相反的过程，直接得到简单类型，不需要转换
 */
@interface NSDictionary (DictionaryExtending)

/*!
 判断是否存在某个键
 @param key 键名
 @return BOOL
 */
- (BOOL)hasValueForKey:(NSString *)key;

/*!
 直接装换成int型
 @param key 键名
 @return int值
 */
- (int)intValueForKey:(NSString *)key;

/*!
 直接装换成BOOL型
 @param key 键名
 @return BOOL值
 */
- (BOOL)boolValueForKey:(NSString *)key;

/*!
 直接装换成double型
 @param key 键名
 @return double值
 */
- (double)doubleValueForKey:(NSString *)key;

/*!
 直接装换成float型
 @param key 键名
 @return float值
 */
- (float)floatValueForKey:(NSString *)key;

/*!
 直接装换成long型
 @param key 键名
 @return long值
 */
- (long)longValueForKey:(NSString *)key;

/*!
 直接装换成long long型
 @param key 键名
 @return long long值
 */
- (long long)longLongValueForKey:(NSString *)key;

/*!
 直接装换成CGRect型
 @param key 键名
 @return CGRect值
 */
- (CGRect)rectValueForKey:(NSString *)key;

/*!
 直接装换成CGPoint型
 @param key 键名
 @return CGPoint值
 */
- (CGPoint)pointValueForKey:(NSString*)key;

/*!
 直接装换成CGSize型
 @param key 键名
 @return CGSize值
 */
- (CGSize)sizeValueForKey:(NSString*)key;

/*!
 The returned C string is automatically freed just as a returned object would be released; you should copy the C string if it needs to store it outside of the autorelease context in which the C string is created.
 */
- (const char *)cStringForKey:(NSString *)key;

/*!
 直接装换成SEL型
 @param key 键名
 @return SEL值
 */
- (SEL)selectorForKey:(NSString *)key;

@end