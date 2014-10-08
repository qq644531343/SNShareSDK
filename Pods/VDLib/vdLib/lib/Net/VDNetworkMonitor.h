/*!
 @header   VDNetworkMonitor
 @abstract 网络监控类,网络改变，使用notification来传递消息
 @author   sunxiao1@staff.sina.com.cn
 */

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"


//#define __NetworkTypeNotificationKey @"NETWORKTYPENOTIFICATIONKEY"
#define NETWORK_TYPE_NOTIFICATION_KEY @"NETWORKTYPENOTIFICATIONKEY"
/*!
 @enum TNetworkType
 @abstract 网络类型
 @constant eNetworkNETUnknown 未知
 @constant eNetworkNETNone 无网络
 @constant eNetworkNETwifi 无线局域网
 @constant eNetworkNETwwan 2G/3G
 */
enum 
{
	eNetworkNETUnknown = -1,
	eNetworkNETNone = 0,		//无网络
	eNetworkNETwifi = 1,
	eNetworkNETwwan = 2,
};
typedef NSInteger TNetworkType;

/*!
 @class VDNetworkMonitor
 @abstract 
 监控类，例子：<br />
 [[VDNetworkMonitor sharedInstance] start] 启动
 [[VDNetworkMonitor sharedInstance] stop] 关闭
 */
@interface VDNetworkMonitor : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDNetworkMonitor)

/*!
 当前的网络类型
 */
@property (nonatomic,readonly) TNetworkType networkType;

/*!
 开始
 @param delay 延迟秒数
 */
- (void) start:(float)delay;

/*!
 立即开始
 */
- (void) start;

/*!
 是否运行
 @return  运行状态
 */
- (BOOL) isStarting;

/*!
 结束
 */
- (void) stop;

@end
