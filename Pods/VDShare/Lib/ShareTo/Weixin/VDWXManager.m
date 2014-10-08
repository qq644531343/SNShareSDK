#import "VDWXManager.h"
#import "VDShareHelper.h"
#import "VDShareAppInfoUtil.h"

@implementation VDWXManager
@synthesize delegeate = _delegeate;
SYNTHESIZE_SINGLETON_FOR_CLASS(VDWXManager)

- (void)dealloc
{
    self.delegeate = nil;
    [super dealloc];
}

- (void) registerApp
{
    [WXApi registerApp:[VDShareAppInfoUtil sharedInstance].weixinAppID];
}

- (void) sendMessage:(VDWXMessage *)message scene:(eVDWXScene) scene
{
    NSAssert(scene >= 0, @"scene不对");
    
    if(message.shareType == eVDWXShareTypeText)
    {
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] autorelease];
        
        req.text = message.content;
        req.bText = YES;
        req.scene = scene;
        
        [WXApi sendReq:req];
    }else if(message.shareType == eVDWXShareTypeImage)
    {
        WXMediaMessage *wxMessage = [WXMediaMessage message];
        WXImageObject *ext = [WXImageObject object];
        ext.imageData = UIImagePNGRepresentation(message.img);
        
        wxMessage.mediaObject = ext;
        
        SendMessageToWXReq *req = [[[SendMessageToWXReq alloc] init] autorelease];
        req.bText = NO;
        req.message = wxMessage;
        req.scene = scene;
        
        [WXApi sendReq:req];
    }else if(message.shareType == eVDWXShareTypeLink)
    {
        WXMediaMessage *wxMessage = [WXMediaMessage message];
        wxMessage.title = message.title;
        wxMessage.description = message.content;
        [wxMessage setThumbImage:message.img];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = message.url;
        wxMessage.mediaObject = ext;
        
        SendMessageToWXReq *req = [[[SendMessageToWXReq alloc] init] autorelease];
        if(message.messageType == eVDWXMessageTypeMultimedia)
        {
            req.bText = NO;
        }else if(message.messageType == eVDWXMessageTypeText)
        {
            req.bText = YES;
        }
        req.scene = scene;
        req.message = wxMessage;
        
        [WXApi sendReq:req];
    }
}

- (void)sendMessageToSession:(VDWXMessage *)message delegate:(id<VDShareManagerDelegate>)delegate
{
    NSAssert(delegate != nil, @"delegate为nil");
    
    //检测是否安装微信客户端
    BOOL res = [WXApi isWXAppInstalled];
    if (res == NO) {
        
        [delegate onShareResponse2:VDShareErrCodeAPPNotInstalled];
        NSLog(@"没有安装微信客户端");
        return;
    }

    
    message.url = [VDShareHelper getPureUrlWithUrl:message.url guestAppType:eTencentWeixin];
    [self sendMessage:message scene:WXSceneSession];
    self.delegeate = delegate;
}

- (void)sendMessageToTimeline:(VDWXMessage *)message delegate:(id<VDShareManagerDelegate>)delegate
{
    NSAssert(delegate != nil, @"delegate为nil");
    
    //检测是否安装微信客户端
    BOOL res = [WXApi isWXAppInstalled];
    if (res == NO) {
        
        [delegate onShareResponse2:VDShareErrCodeAPPNotInstalled];
        NSLog(@"没有安装微信客户端");
        return;
    }

    
    message.url = [VDShareHelper getPureUrlWithUrl:message.url guestAppType:eTencentWeixin];
    [self sendMessage:message scene:WXSceneTimeline];
    self.delegeate = delegate;
    
}

- (void)sendMessageToFavorite:(VDWXMessage *)message delegate:(id<VDShareManagerDelegate>)delegate
{
    NSAssert(delegate != nil, @"delegate为nil");
    message.url = [VDShareHelper getPureUrlWithUrl:message.url guestAppType:eTencentWeixin];
    [self sendMessage:message scene:WXSceneFavorite];
    self.delegeate = delegate;
}

- (void)onReq:(BaseReq *)req
{
    NSAssert(self.delegeate, @"没有绑定respDelegate");
    if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信直接启动过来
        if([self.delegeate respondsToSelector:@selector(onShareRequest:respData:)])
        {
            [self.delegeate onShareRequest:YES respData:[VDShareParamHelper getRespBase:share_resp_type]];
        }
    }
}

- (void)onResp:(BaseResp *)resp
{
    NSAssert(self.delegeate, @"没有绑定reqDelegate");
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        //微信发送消息返回
        if(resp.errCode == 0)
        {
            if([self.delegeate respondsToSelector:@selector(onShareResponse:)])
            {
                [self.delegeate onShareResponse:YES];
            }
            if([self.delegeate respondsToSelector:@selector(onShareResponse2:)])
            {
                [self.delegeate onShareResponse2:VDShareErrCodeNoErr];
            }
        }else if(resp.errCode == WXErrCodeUserCancel)
        {
            if([self.delegeate respondsToSelector:@selector(onShareResponse:)])
            {
                [self.delegeate onShareResponse:NO];
            }
            if([self.delegeate respondsToSelector:@selector(onShareResponse2:)])
            {
                [self.delegeate onShareResponse2:VDShareErrCodeUserCancel];
            }
        }else{
            if([self.delegeate respondsToSelector:@selector(onShareResponse:)])
            {
                [self.delegeate onShareResponse:NO];
            }
            if([self.delegeate respondsToSelector:@selector(onShareResponse2:)])
            {
                [self.delegeate onShareResponse2:VDShareErrCodeCommonErr];
            }
        }
    }
    
}

-(BOOL)handleOpenUrl:(UIApplication *)app url:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}

@end
