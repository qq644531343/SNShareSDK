
/*!
 @header   SystemUtil
 @abstract 这个类的目的就是提供系统一次创建的变量，所以遇到这样的变量，就直接在这找；
           如果没有的话，请加上（而不是放过） 此外SystemUtil这个名字是我的使用习惯，
           如果有好建议，欢迎提出
 @author   zhouchen3@staff.sina.com.cn
 */

#import <Foundation/Foundation.h>

#define SYSTEM_UTIL(args)    [[SystemUtil sharedInstance] args]

@interface SystemUtil : NSObject

/*!
 @method sharedInstance
 @brief 单例
 @return SystemUtil
 */
+ (id)sharedInstance;

/*!
 @method appVersion
 @brief 获取app版本号
 @return app版本号
 */
- (NSString *)appVersion;

/*!
 @method appBuild
 @brief 获取app构建号
 @return app构建号
 */
- (NSString *)appBuild;

/*!
 @method appVersion
 @brief 获取app版本号+构建号
 @return app构建号+构建号
 */
- (NSString *)appVersion_Build;

/*!
 @method systemVersion
 @brief 获取系统版本号
 @return 系统版本号
 */
- (NSString *)systemVersion;

/*!
 @method deviceID
 @brief 获取设备ID，目前各个地方都用的Did
 @return 设备ID
 */
- (NSString *)deviceID;
- (NSString *)Did;

/*!
 @method platform
 @brief 获取设备platform
 @return platform:iPhone5,3  platformString:iPhone 5C (GSM)
 */
- (NSString *)platform;
- (NSString *)platformString;

/*!
 @method screenBounds
 @brief 获得屏幕尺寸
 @return 屏幕尺寸
 */
- (CGRect)screenBounds;

/*!
 @method isIphone
 @brief 判断是否是iPhone
 @return isIphone
 */
- (BOOL)isIphone;

/*!
 @method isIphone5
 @brief 判断是否是isIphone5或以上
 @return isIphone5
 */
- (BOOL)isIphone5;

/*!
 @method isIOS7
 @brief 判断是否是IOS7或以上
 @return isIOS7
 */
- (BOOL)isIOS7;

/*!
 @method documentPath
 @brief 获取document路径
 @return document路径
 */
- (NSString *)documentPath;

/*!
 @method libraryPath
 @brief 获取library路径
 @return library路径
 */
- (NSString *)libraryPath;

/*!
 @method temporaryPath
 @brief 获取temporaryPath路径
 @return temporaryPath路径
 */
- (NSString *)temporaryPath;

/*!
 @method cachePath
 @brief 获取cachePath路径
 @return cachePath路径
 */
- (NSString *)cachePath;

@end
