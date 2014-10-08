/*!
 @header 
 @abstract NSMutableDictionary扩展，用来将简单类型置入到字典中
 */
#import <Foundation/Foundation.h>

/*!
 NSMutableDictionary扩展 将简单类型存入字典不需要转换
 */
@interface NSMutableDictionary (DictionaryExtending)

/*!
 存入int类型值
 
 @param intValue int值
 @param key      键值
 */
- (void)setIntValue:(int)intValue forKey:(NSString *)key;

/*!
 存入BOOL类型值
 
 @param boolValue BOOL值
 @param key      键值
 */
- (void)setBoolValue:(BOOL)boolValue forKey:(NSString *)key;

/*!
 存入Double类型值
 
 @param doubleValue Double值
 @param key      键值
 */
- (void)setDoubleValue:(double)doubleValue forKey:(NSString *)key;

/*!
 存入Float类型值
 
 @param floatValue Float值
 @param key      键值
 */
- (void)setFloatValue:(float)floatValue forKey:(NSString *)key;

/*!
 存入long类型值
 
 @param longValue long值
 @param key      键值
 */
- (void)setLongValue:(long)longValue forKey:(NSString *)key;

/*!
 存入longLong类型值
 
 @param longLongValue long值
 @param key      键值
 */
- (void)setLongLongValue:(long long)longLongValue forKey:(NSString *)key;

/*!
 存入CGRect类型值
 
 @param rect CGRect值
 @param key      键值
 */
- (void)setRect:(CGRect)rect forKey:(NSString *)key;

/*!
 存入CGSize类型值
 
 @param si CGSize值
 @param key      键值
 */
- (void)setSize:(CGSize)si forKey:(NSString *)key;

/*!
 存入CGPoint类型值
 
 @param point CGPoint值
 @param key      键值
 */
- (void)setPoint:(CGPoint)point forKey:(NSString*)key;

/*!
 存入const char *类型值
 
 @param cString const char *值
 @param key      键值
 */
- (void)setCString:(const char *)cString forKey:(NSString *)key;

/*!
 存入SEL类型值
 
 @param selector SEL值
 @param key      键值
 */
- (void)setSelector:(SEL)selector forKey:(NSString *)key;

@end