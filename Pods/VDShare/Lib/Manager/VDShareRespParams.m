#import "VDShareRespParams.h"

@implementation VDShareParamHelper

+ (VDShareRespBase *)getRespBase:(eVDShareRespBaseType) type
{
    switch (type) {
        case eVDShareRespBaseTypeUnknown:
        default:
            return nil;
            break;
        case eVDShareRespBaseTypeVideo:
            return [[[VDShareRespVideoParams alloc] init] autorelease];
            break;
    }
}

@end

@implementation VDShareRespBase

- (id)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

-(void)dealloc
{
    [super dealloc];
}

@end

@implementation VDShareRespVideoParams
@synthesize videoID = _videoID;

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    self.videoID = nil;
    [super dealloc];
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"videoID:%@",self.videoID];
}

@end
