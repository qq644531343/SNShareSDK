//
//  手Q以及Qzone消息类
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VDQQCommon.h"
//#import "VDLibGlobal.h"
#import "VDShareSynthesizeSingleton.h"
#import "VDShareMultimediaParams.h"

@interface VDQQMessage : NSObject
{
}

@property (nonatomic,assign) eVDQQMessageType type;

@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *url;
@property(nonatomic, retain) NSString *imgUrl;
@property(nonatomic, retain) UIImage  *image;
@property(nonatomic, retain) NSString *description;

@property (nonatomic,retain) VDShareVideoParam *videoUrl;
@property (nonatomic,retain) VDShareAudioParam *audioUrl;

- (eVDQQMessageType) getType;

@end
