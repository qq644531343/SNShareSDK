//
// 分享部分的总的数据类，从外部直接设置这个就可以了。
//

#import <Foundation/Foundation.h>
//#import "VDLibGlobal.h"
#import "VDShareSynthesizeSingleton.h"
#import "VDQQMessage.h"
#import "VDWeiboMessage.h"
#import "VDWXMessage.h"
#import "VDShareMultimediaParams.h"
#import "VDShareParamAddOn.h"

#define kShareActionTitleWeiXin             @"微信"
#define kShareActionTitleWeiXinMoments      @"朋友圈"
#define kShareActionTitleQzone              @"QQ空间"
#define kShareActionTitleQQ                 @"QQ"
#define kShareActionTitleSinaWeiBo          @"新浪微博"
#define kShareActionTitleCancel             @"取消分享"


@interface VDShareParam : NSObject 
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDShareParam)
//发送信息
//@property (nonatomic, retain) NSString  *summary;
@property (nonatomic, retain) NSString  *title;
@property (nonatomic, retain) NSString  *description;
@property (nonatomic, retain) NSString  *url;
//@property (nonatomic, retain) NSString  *name;
@property (nonatomic, retain) NSString  *imgUrl;
@property (nonatomic, retain) UIImage   *image;
@property (nonatomic,retain)  VDShareVideoParam *videoUrl;
@property (nonatomic,retain) VDShareAudioParam *audioUrl;
////返回时候使用
@property (nonatomic, copy)   NSString* videoID;
/*!
 新加入的扩展字段，在如下特殊情况下，设置此值
 1、使用多图接口传多图到新浪微博
 */
@property (nonatomic,retain) VDShareParamAddOn *addOn;
//
- (VDWXMessage *)convertToWX:(eVDWXMessageType) messageType shareType:(eVDWXShareType) shareType;
- (VDWeiboMessage *)convertToWeibo:(eVDWeiboMessageType) type;
- (VDQQMessage *)convertToQQ:(eVDQQMessageType) type;
@end
