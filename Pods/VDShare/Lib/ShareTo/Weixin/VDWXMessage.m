#import "VDWXMessage.h"

@interface VDWXMessage()

@end

@implementation VDWXMessage
@synthesize title = _title,content = _content,img = _img,url = _url;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title];
    [aCoder encodeObject:self.content];
    [aCoder encodeObject:self.img];
    [aCoder encodeObject:self.url];
}

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (NSString *)description
{
    NSString *ret = [NSString stringWithFormat:@"title:%@,content:%@,url:%@",self.title,self.content,self.url];
    if(self.img)
    {
        return [NSString stringWithFormat:@"%@,img size:%@",ret,NSStringFromCGSize(self.img.size)];
    }
    return ret;
}

@end
