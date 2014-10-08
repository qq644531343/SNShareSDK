#import "VDShareParam.h"

@interface UIImage (Extensions)
{}

- (UIImage *)imageByScalingSize:(float) scale;

@end

@implementation UIImage(Extensions)

-  (UIImage *)imageByScalingSize:(float)scale
{
    UIGraphicsBeginImageContext(CGSizeMake(self.size.width * scale, self.size.height * scale));
    [self drawInRect:CGRectMake(0, 0, self.size.width * scale, self.size.height * scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end

@interface VDShareParam()
{
}

@end

@implementation VDShareParam
//@synthesize summary = _summary;
@synthesize title = _title;
@synthesize description = _description;
//@synthesize name = _name;
@synthesize url = _url;
@synthesize image = _image;
@synthesize videoUrl = _videoUrl;
@synthesize audioUrl = _audioUrl;
@synthesize addOn = _addOn;
SYNTHESIZE_SINGLETON_FOR_CLASS(VDShareParam)

- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc
{
    self.title = nil;
    self.description = nil;
    self.url = nil;
    self.image = nil;
    self.videoUrl = nil;
    self.audioUrl = nil;
    self.addOn = nil;
    [super dealloc];
}

- (VDQQMessage *)convertToQQ:(eVDQQMessageType) type
{
    VDQQMessage *message = [[[VDQQMessage alloc] init] autorelease];
    message.title = self.title;
    message.description = self.description;
    message.url = self.url;
    message.image = self.image;
    message.imgUrl = self.imgUrl;
    message.videoUrl = self.videoUrl;
    message.audioUrl = self.audioUrl;
    message.type = type;
    
    return message;
}

- (VDWXMessage *)convertToWX:(eVDWXMessageType) messageType shareType:(eVDWXShareType) shareType
{
    VDWXMessage *message = [[[VDWXMessage alloc] init] autorelease];
    
    message.title = self.title;
    message.content = self.description;
    message.url = self.url;
    if(!self.image)
    {
        [message setImg:[UIImage imageNamed:@"icon.png"]];
    }else{
        UIImage *img = self.image;
        NSUInteger length = UIImagePNGRepresentation(img).length;
        //微信要求图片尺寸不能超过32K
        if (length > 32 * 1024)
        {
			float scale = sqrtf((32*1024*1.0f) / length);
            img = [img imageByScalingSize:scale];
        }
        message.img = img;
    }
    message.messageType = messageType;
    message.shareType = shareType;
    
    return message;
}

- (VDWeiboMessage *)convertToWeibo:(eVDWeiboMessageType) type
{
    VDWeiboMessage *message = [[[VDWeiboMessage alloc] init] autorelease];
    message.text = self.title;
    message.imageOrThumbnail = self.image;
    message.webTitle = self.title;
    message.webDesc = self.description;
    message.webUrl = self.url;
    message.videoUrl = self.videoUrl;
    message.type = type;
    
    if(self.addOn && self.addOn.picIDList)
    {
        message.picIDArr = self.addOn.picIDList;
    }
    
    return message;
}
@end
