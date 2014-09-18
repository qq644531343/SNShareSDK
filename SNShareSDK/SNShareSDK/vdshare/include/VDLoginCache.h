//
//  登录部分的缓冲类，外部不要调用
//

#import <Foundation/Foundation.h>
#import "VDWeiboLoginMessage.h"
//#import "VDLibGlobal.h"
#import "VDShareSynthesizeSingleton.h"

#define kVDWeiboLoginCacheFilename @"login.dat"

@interface VDLoginCache : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDLoginCache)

//缓冲目录
- (NSString *) getWeiboLoginCachePath;

//清理登录的缓冲部分
- (void) removeWeiboLoginMessage;

//将登录信息同步到缓冲中
- (void) syncWeiboLoginMessage:(VDWeiboLoginMessage *)message;

//取出相应的登录信息
- (VDWeiboLoginMessage *) getWeiboLoginMessage;

@end
