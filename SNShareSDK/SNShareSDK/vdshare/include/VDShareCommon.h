//
//  分享基础类，协议部分
//

#import "VDShareSynthesizeSingleton.h"
#import "VDShareRespParams.h"

typedef enum
{
    VDShareErrCodeNoErr = 0, //没有错误
    VDShareErrCodeCommonErr, //未知错误
    VDShareErrCodeUserCancel, //用户取消
    VDShareErrCodeSendErr, //发送失败
    VDShareErrCodeAuthDeny, //授权失败
    VDShareErrCodeUnsupport, //客户端不支持
    VDShareErrCodeImgIsNil, //分享的图片为空
    VDShareErrCodeAttachmentOversize, //附件过大
    VDShareErrCodeAPPNotInstalled, //客户端未安装
    VDShareErrCodeUserTokenErr, //token信息失效，一般为登录超时或者未登录导致
}VDShareErrCode;

const static eVDShareRespBaseType share_resp_type = eVDShareRespBaseTypeVideo;

/**
 分享的协议，从appdelegate里面传过来的
 */
@protocol VDShareManagerDelegate <NSObject>

@optional
- (void) onShareRequest:(BOOL) isOK respData:(VDShareRespBase *) respData;
- (void) onShareResponse:(BOOL) isOK;
@optional
//使用这个来取得错误状态
- (void) onShareResponse2:(VDShareErrCode) errCode;
@end

/*!
 上传图片到新浪微博，专用Delegate
 */
@protocol VDWeiboUploadPicDelegate <NSObject>

@required
- (void) onUploadRequest:(BOOL) isOk picID:(NSString *) picID key:(NSString *) key;
@optional
- (void) onUploadError:(int) code desc:(NSString *) desc;

@end

/**
 登录协议
 */
@protocol VDWeiboManagerLoginDelegate <NSObject>
@optional
- (void) onWeiboManagerSuccessLogin;
- (void) onWeiboManagerFailLogin;
- (void) onWeiboManagerLogout;
@end

/**
 * 检查登录状态
 */
@protocol VDWeiboManagerCheckLoginDelegate <NSObject>

@required
- (void) onCheckResult:(VDShareErrCode) code;

@end

