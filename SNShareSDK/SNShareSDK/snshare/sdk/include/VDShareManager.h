//
//  分享管理类，所有请求从这儿发出去
//

#import <Foundation/Foundation.h>
//#import "VDLibGlobal.h"
#import "VDShareSynthesizeSingleton.h"
#import "VDShareCommon.h"
#import "VDShareParam.h"

#import "VDWXMessage.h"
#import "VDWeiboMessage.h"
#import "VDQQMessage.h"

#import "VDWXManager.h"
#import "VDQQManager.h"
#import "VDWeiboManager.h"

/**
 从微信等回来的连接：
 sinavideo://details/[视频html]?app=[weixin]|[qq]|[weibo]
 **/

/**个股分享
 *暂不支持微信分享
 */
@interface VDShareManager : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDShareManager)

//注册
-(void) registerApp;

#pragma mark 发送部分
//微信好友
- (void)shareToWXWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>) delegate shareType:(eVDWXShareType) shareType messageType:(eVDWXMessageType) messageType;

//微信朋友圈
- (void)shareToWXMomentsWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>) delegate shareType:(eVDWXShareType) shareType messageType:(eVDWXMessageType) messageType;

//分享到手机QQ
- (void)shareToShouQQWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>) delegate messageType:(eVDQQMessageType) messageType;

//分享到新浪微博
- (void)shareToWeiboWthObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>) delegate messageType:(eVDWeiboMessageType) messageType;

//分享到QQ空间
- (void)shareToQzoneWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>) delegate messageType:(eVDQQMessageType) messageType;


//上传图片到微博
- (void)uploadPic:(UIImage *)pic accessToken:(NSString *)accessToken key:(NSString *) key delegate:(id<VDWeiboUploadPicDelegate>)delegate;

#pragma mark 从其他客户端回来的部分
//从其他客户端回来的部分
- (BOOL) handleOpenUrl:(UIApplication *)app url:(NSURL *)url;
@end

