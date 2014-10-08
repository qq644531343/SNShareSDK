
/*!
 @header getddidsdk.h
 @abstract 获取DeviceID
 */

#import <Foundation/Foundation.h>
#import <AdSupport/ASIdentifierManager.h>
#import <CommonCrypto/CommonDigest.h>

@interface getddidsdk : NSObject
/*!
 获取open udid 或 adid 然后md5生成 32字符串（暂叫：did）。
 对这32位字符（did）做校验。
 校验方式： （did + 日期 + 密码）做md5生成32位字符串（暂叫：checkid）
 最终的deviceid = did + checkid的后8位（共40位的字符串）
 */
+ (NSString *)Did;
+ (NSString *)DeviceId;
+ (NSString *)oldDeviceId;

@end
