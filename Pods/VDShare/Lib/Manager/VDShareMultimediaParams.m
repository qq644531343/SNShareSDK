#import "VDShareMultimediaParams.h"

@implementation VDShareAudioParam

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.audioWebUrl = [aDecoder decodeObject];
        self.audioStreamUrl = [aDecoder decodeObject];
        self.audioLowbandWebUrl = [aDecoder decodeObject];
        self.audioLowBandStreamUrl = [aDecoder decodeObject];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.audioWebUrl];
    [aCoder encodeObject:self.audioStreamUrl];
    [aCoder encodeObject:self.audioLowbandWebUrl];
    [aCoder encodeObject:self.audioLowBandStreamUrl];
}

- (void)dealloc
{
    self.audioWebUrl = nil;
    self.audioStreamUrl = nil;
    self.audioLowbandWebUrl = nil;
    self.audioLowBandStreamUrl = nil;
    [super dealloc];
}

@end

@implementation VDShareVideoParam

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.videoUrl = [aDecoder decodeObject];
        self.videoStreamUrl = [aDecoder decodeObject];
        self.videoLowBandUrl = [aDecoder decodeObject];
        self.videoLowBandStreamUrl = [aDecoder decodeObject];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.videoUrl];
    [aCoder encodeObject:self.videoStreamUrl];
    [aCoder encodeObject:self.videoLowBandUrl];
    [aCoder encodeObject:self.videoLowBandStreamUrl];
}

- (void)dealloc
{
    self.videoUrl = nil;
    self.videoStreamUrl = nil;
    self.videoLowBandUrl = nil;
    self.videoLowBandStreamUrl = nil;
    [super dealloc];
}

@end