//
//  微信部分的管理类
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#import "WXApiObject.h"
//#import "VDLibGlobal.h"
#import "VDShareSynthesizeSingleton.h"
#import "VDWXCommon.h"
#import "VDWXMessage.h"
#import "VDShareCommon.h"

typedef NSUInteger eVDWXScene;

@interface VDWXManager : NSObject<WXApiDelegate>
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDWXManager)

@property (nonatomic,assign) id<VDShareManagerDelegate> delegeate;

//注册
- (void) registerApp;

//分享到朋友圈
- (void) sendMessageToTimeline:(VDWXMessage *)message delegate:(id<VDShareManagerDelegate>) delegate;
//分享到对话
- (void) sendMessageToSession:(VDWXMessage *)message delegate:(id<VDShareManagerDelegate>) delegate;
//分享到收藏
- (void) sendMessageToFavorite:(VDWXMessage *)message delegate:(id<VDShareManagerDelegate>) delegate;

//处理从微信返回的问题
- (BOOL) handleOpenUrl:(UIApplication *)app url:(NSURL *)url;

@end
