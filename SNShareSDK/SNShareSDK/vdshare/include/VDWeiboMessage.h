//
//  微博分享数据类
//
#import <Foundation/Foundation.h>
#import "VDShareMultimediaParams.h"

typedef enum
{
    eVDWeiboMessageTypeText,
    eVDWeiboMessageTypeImage,
    eVDWeiboMessageTypeUrl,
    eVDWeiboMessageTypeVideo,
    eVDWeiboMessageTypeAudio,
    eVDWeiboMessageTypeOpenAPI, //增加一个openapi方式发送接口
    eVDWeiboMessageTypeAdvOpenAPI, //增加一个openapi方式发送接口，可以发送图片
    eVDWeiboMessageTypeMultiPicOpenAPI, //增加一个openapi方式发送多图的接口,设置此值，需要同时设置VDShareParam.addon
} eVDWeiboMessageType;

@interface VDWeiboMessage : NSObject
{
}

@property (nonatomic,retain) NSString *text;
@property (nonatomic,retain) UIImage *imageOrThumbnail;
@property (nonatomic,retain) NSString *webTitle;
@property (nonatomic,retain) NSString *webDesc;
//@property (nonatomic,retain) NSString *webObjID;
@property (nonatomic,retain) NSString *webUrl;
@property (nonatomic,retain) VDShareVideoParam *videoUrl;
@property (nonatomic,retain) VDShareAudioParam *audioUrl;
@property (nonatomic,assign) eVDWeiboMessageType type;
/*!
 用于多图分享微博
 */
@property (nonatomic,retain) NSArray *picIDArr;

@end
