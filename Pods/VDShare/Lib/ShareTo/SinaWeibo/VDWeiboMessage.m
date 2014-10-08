#import "VDWeiboMessage.h"

@implementation VDWeiboMessage

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
    self.text = nil;
    self.imageOrThumbnail = nil;
    self.webTitle = nil;
    self.webDesc = nil;
    self.webUrl = nil;
    self.videoUrl = nil;
    self.audioUrl = nil;
    self.picIDArr = nil;
    [super dealloc];
}

- (NSString *)description
{
    NSMutableString *ret = [NSMutableString stringWithFormat:@"text:%@,imageOrThumbnail size:%@,webTitle:%@,webDesc:%@,webUrl:%@,videoUrl:%@,audioUrl:%@",self.text,NSStringFromCGSize(self.imageOrThumbnail.size),self.webTitle,self.webDesc,self.webUrl,self.videoUrl,self.autorelease];
    
    if(self.picIDArr)
    {
        [ret appendString:@"\npicIDArr:\n"];
        for(NSString *value in self.picIDArr)
        {
            [ret appendString:[NSString stringWithFormat:@"%@\n",value]];
        }
    }
    
    return ret;
}

@end
