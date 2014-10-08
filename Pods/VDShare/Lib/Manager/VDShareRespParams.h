//
//  从客户端直接请求过来的数据，用来打开当前App的界面，如果是其他业务，请自定义VDShareRespBase
//

#import <Foundation/Foundation.h>

typedef enum {
    eVDShareRespBaseTypeUnknown,
    eVDShareRespBaseTypeVideo,
} eVDShareRespBaseType;

@interface VDShareRespBase : NSObject

@end

@interface VDShareRespVideoParams : VDShareRespBase
@property (nonatomic,retain) NSString *videoID;
@end

@interface VDShareParamHelper : NSObject
+ (VDShareRespBase *)getRespBase:(eVDShareRespBaseType) type;
@end
