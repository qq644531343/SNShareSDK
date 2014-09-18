//
//  微信部分的数据结构
//

#import <Foundation/Foundation.h>
#import "VDWXCommon.h"

@interface VDWXMessage : NSObject <NSCoding>
{
}
@property (nonatomic,retain) NSString *title;
@property (nonatomic,retain) NSString *content;
@property (nonatomic,retain) UIImage *img;
@property (nonatomic,retain) NSString *url;
@property (nonatomic,assign) eVDWXMessageType messageType;
@property (nonatomic,assign) eVDWXShareType shareType;
@property (nonatomic,assign) NSString *videoUrl;

@end
