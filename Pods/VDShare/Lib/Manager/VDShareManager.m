#import "VDShareManager.h"
#import "VDWeiboUploadPicHelper.h"

@interface VDShareManager()
@end

@implementation VDShareManager
SYNTHESIZE_SINGLETON_FOR_CLASS(VDShareManager)

- (id)init
{
    if ((self = [super init]) != nil){
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)registerApp
{
    [[VDWeiboManager sharedInstance] registerApp];
    [[VDWXManager sharedInstance] registerApp];
    [[VDQQManager sharedInstance] registerApp];
}

- (void)shareToWXWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>) delegate shareType:(eVDWXShareType) shareType messageType:(eVDWXMessageType) messageType
{
    [[VDWXManager sharedInstance] sendMessageToSession:[obj convertToWX:messageType shareType:shareType] delegate:delegate];
}

- (void)shareToWXMomentsWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>) delegate shareType:(eVDWXShareType) shareType messageType:(eVDWXMessageType) messageType
{
    [[VDWXManager sharedInstance] sendMessageToTimeline:[obj convertToWX:messageType shareType:shareType] delegate:delegate];
}

- (void)shareToWeiboWthObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>)delegate messageType:(eVDWeiboMessageType)messageType
{
    [[VDWeiboManager sharedInstance] sendMessage:[obj convertToWeibo:messageType] delegate:delegate];
}

- (void)uploadPic:(UIImage *)pic accessToken:(NSString *)accessToken key:(NSString *) key delegate:(id<VDWeiboUploadPicDelegate>)delegate
{
    [[VDWeiboUploadPicHelper sharedInstance] uploadPic:pic accessToken:accessToken key:key delegate:delegate];
}

- (void)shareToQzoneWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>)delegate messageType:(eVDQQMessageType)messageType
{
    [[VDQQManager sharedInstance] sendMessageToQzone:[obj convertToQQ:messageType] delegate:delegate];
}

- (void)shareToShouQQWithObject:(VDShareParam *)obj delegate:(id<VDShareManagerDelegate>)delegate messageType:(eVDQQMessageType)messageType
{
    [[VDQQManager sharedInstance] sendMessageToUsers:[obj convertToQQ:messageType] delegate:delegate];
}

- (BOOL) handleOpenUrl:(UIApplication *)app url:(NSURL *)url
{
    [[VDWXManager sharedInstance] handleOpenUrl:app url:url];
    [[VDWeiboManager sharedInstance] handleOpenUrl:app url:url];
    [[VDQQManager sharedInstance] handleOpenUrl:app url:url];
    return YES;
}

@end
