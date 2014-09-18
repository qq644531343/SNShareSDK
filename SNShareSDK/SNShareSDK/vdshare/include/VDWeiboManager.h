/*!
 @header VDWeiboManager
 @abstract 微博分享以及登录管理类
 */

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#import "VDShareSynthesizeSingleton.h"
#import "VDShareMacro.h"
#import "VDWeiboCommon.h"
#import "VDWeiboLoginMessage.h"
#import "VDWeiboMessage.h"
#import "VDShareCommon.h"
#import "VDLoginCache.h"

@interface VDWeiboManager : NSObject <WeiboSDKDelegate,WBHttpRequestDelegate>
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDWeiboManager)

@property (nonatomic,retain) id<VDShareManagerDelegate> delegate;
@property (nonatomic,retain) id<VDWeiboManagerLoginDelegate> loginDelegate;

/*!
 注册app
 */
- (void) registerApp;
/*!
 注册login
 */
- (void) registerLogin;

/*!
 分享消息
 
 @param message
 @param delegate
 */
- (void) sendMessage:(VDWeiboMessage *) message delegate:(id<VDShareManagerDelegate>) delegate;

/*!
 取得用户登录情况
 
 @return
 */
- (VDWeiboLoginMessage *) getLoginMessage;
- (void) login:(id<VDWeiboManagerLoginDelegate>) delegate;
- (void) loginOut;
- (void) appendExtUserData:(VDWeiboLoginMessage *)message;
/*!
 检查用户状态，同步调用，调用后如果验证出错，会清理登录信息
 
 @param delegate
 
 @return
 */
- (BOOL) checkTokenValid:(id<VDShareManagerDelegate>) delegate;

/*!
 注册到appdelegate里面
 
 @param app
 @param url
 
 @return
 */
-(BOOL)handleOpenUrl:(UIApplication *)app url:(NSURL *)url;

@end
