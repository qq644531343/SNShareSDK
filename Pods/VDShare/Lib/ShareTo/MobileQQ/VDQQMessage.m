//#import <TencentOpenAPI/QQApi.h>
#import "VDQQMessage.h"
#import "VDShareMultimediaParams.h"

@interface VDQQMessage()
@end

@implementation VDQQMessage
@synthesize title=_title,url=_url,image=_image, description=_description;
@synthesize imgUrl = _imgUrl,videoUrl = _videoUrl,audioUrl = _audioUrl;

- (id)init
{
    if ((self = [super init]) != nil)
    { 
    }
    
    return self;
}

- (eVDQQMessageType)getType
{
    return self.type;
}

- (void)dealloc
{
    self.title = nil;
    self.url = nil;
    self.image = nil;
    self.description = nil;
    
    [super dealloc];
}
@end
