#import "VDQQManager.h"
#import "VDShareHelper.h"
#import "VDShareAppInfoUtil.h"

@interface VDQQManager()
@property (nonatomic,retain) TencentOAuth *oauth;
@end

@implementation VDQQManager
@synthesize delegate = _delegate;
@synthesize oauth = _oauth;
SYNTHESIZE_SINGLETON_FOR_CLASS(VDQQManager)

- (id)init
{
    self = [super init];
    if(self)
    {
        self.delegate = nil;
        self.oauth = nil;
    }
    return self;
}

- (void)registerApp
{
    TencentOAuth *oauth = [[TencentOAuth alloc] initWithAppId:[VDShareAppInfoUtil sharedInstance].mobileQQAppID andDelegate:self];
    self.oauth = oauth;
    [oauth release];
}

-(void)dealloc
{
    self.delegate = nil;
    self.oauth = nil;
    [super dealloc];
}

- (void)tencentDidLogin
{
    DLog(@"tencentDidLogin");
}

-(void)tencentDidNotNetWork
{
    DLog(@"tencentDidNotNetWork");
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    DLog(@"tencentDidNotLogin");
}

- (void)sendMessageToUsers:(VDQQMessage *)message delegate:(id<VDShareManagerDelegate>)delegate
{
    NSAssert(delegate != nil, @"delegate为nil");
    self.delegate = delegate;
    if(![TencentOAuth iphoneQQInstalled])
    {
        if([self.delegate respondsToSelector:@selector(onShareResponse:)])
        {
            [self.delegate onShareResponse:NO];
        }
        if([self.delegate respondsToSelector:@selector(onShareResponse2:)])
        {
            [self.delegate onShareResponse2:VDShareErrCodeAPPNotInstalled];
        }
        return;
    }
    
    message.url = [VDShareHelper getPureUrlWithUrl:message.url guestAppType:eTencentQQ];
    
    if(![QQApiInterface isQQInstalled] || ![QQApiInterface isQQSupportApi])
    {
        NSURL *url = [NSURL URLWithString:[QQApiInterface getQQInstallUrl]];
        [[UIApplication sharedApplication] openURL:url];
    }
    
    QQApiSendResultCode sent = EQQAPISENDSUCESS;
    if([message getType] == eVDQQMessageTypeText)
    {
        //分享文字，就一段话，没有连接
        QQApiTextObject *obj = [QQApiTextObject objectWithText:message.title];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
        sent = [QQApiInterface sendReq:req];
    }else if([message getType] == eVDQQMessageTypeImage)
    {
        //分享图片，没有连接
        NSData *data = UIImagePNGRepresentation(message.image);
        QQApiImageObject *obj = [QQApiImageObject objectWithData:data previewImageData:data title:message.title description:message.description];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:obj];
        sent = [QQApiInterface sendReq:req];
    }else if([message getType] ==eVDQQMessageTypeNews)
    {
        //分享带本地图片的资讯类型
        QQApiNewsObject *newsObj = nil;
        if(!message.imgUrl)
        {
            newsObj = [QQApiNewsObject
                       objectWithURL:[NSURL URLWithString:message.url?:@""]
                       title:message.title
                       description:message.description
                       previewImageData:UIImagePNGRepresentation(message.image)];
        }else{
            newsObj = [QQApiNewsObject
                       objectWithURL:[NSURL URLWithString:message.url?:@""]
                       title:message.title
                       description:message.description
                       previewImageURL:[NSURL URLWithString:message.imgUrl]];
        }
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        sent = [QQApiInterface sendReq:req];
    }else if([message getType] == eVDQQMessageTypeAudio)
    {
        //分享音频
        QQApiAudioObject *audioObj = nil;
        if(!message.imgUrl)
        {
            audioObj = [QQApiAudioObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                                 title:message.title
                                           description:message.description
                                      previewImageData:UIImagePNGRepresentation(message.image)];
        }else{
            audioObj = [QQApiAudioObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                                 title:message.title
                                           description:message.description
                                       previewImageURL:[NSURL URLWithString:message.imgUrl]];
        }
        [audioObj setFlashURL:[NSURL URLWithString:message.audioUrl.audioWebUrl?:@""]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
        sent = [QQApiInterface sendReq:req];
    }else if([message getType] == eVDQQMessageTypeVideo)
    {
        //分享视频
        QQApiVideoObject *videoObj = nil;
        if(!message.imgUrl)
        {
            videoObj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                                 title:message.title description:message.description previewImageData:UIImagePNGRepresentation(message.image)];
        }else{
            videoObj = [QQApiVideoObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                                 title:message.title description:message.description previewImageURL:[NSURL URLWithString:message.imgUrl]];
        }
        [videoObj setFlashURL:[NSURL URLWithString:message.videoUrl.videoUrl?:@""]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
        sent = [QQApiInterface sendReq:req];
    }else{
        NSAssert(YES, @"message getType不支持");
    }
    
    if(sent != EQQAPISENDSUCESS)
    {
        DLog(@"not EQQAPISENDSUCESS");
    }
}


- (void)sendMessageToQzone:(VDQQMessage *)message delegate:(id<VDShareManagerDelegate>)delegate
{
    NSAssert(delegate != nil, @"delegate为nil");
    self.delegate = delegate;
    
    message.url = [VDShareHelper getPureUrlWithUrl:message.url guestAppType:eTencentQzone];
    
    QQApiSendResultCode sent = EQQAPISENDSUCESS;
    if([message getType] ==eVDQQMessageTypeNews)
    {
        QQApiNewsObject *newsObj = nil;
        if(!message.imgUrl)
        {
            newsObj = [QQApiNewsObject
                       objectWithURL:[NSURL URLWithString:message.url?:@""]
                       title:message.title
                       description:message.description
                       previewImageData:UIImagePNGRepresentation(message.image)];
        }else{
            newsObj = [QQApiNewsObject
                       objectWithURL:[NSURL URLWithString:message.url?:@""]
                       title:message.title
                       description:message.description
                       previewImageURL:[NSURL URLWithString:message.imgUrl]];
        }
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
        
        sent = [QQApiInterface SendReqToQZone:req];
    }else if([message getType] == eVDQQMessageTypeAudio)
    {
        QQApiAudioObject *audioObj = nil;
        if(!message.imgUrl)
        {
            audioObj = [QQApiAudioObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                                 title:message.title
                                           description:message.description
                                      previewImageData:UIImagePNGRepresentation(message.image)];
        }else{
            audioObj = [QQApiAudioObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                                 title:message.title
                                           description:message.description
                                       previewImageURL:[NSURL URLWithString:message.imgUrl]];
        }
        [audioObj setFlashURL:[NSURL URLWithString:message.audioUrl.audioWebUrl?:@""]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:audioObj];
        
        sent = [QQApiInterface SendReqToQZone:req];
    }else if([message getType] == eVDQQMessageTypeVideo)
    {
        QQApiVideoObject *videoObj = nil;
        if(!message.imgUrl)
        {
            [QQApiVideoObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                      title:message.title description:message.description
                           previewImageData:UIImagePNGRepresentation(message.image)];
        }else{
            [QQApiVideoObject objectWithURL:[NSURL URLWithString:message.url?:@""]
                                      title:message.title description:message.description previewImageData:UIImagePNGRepresentation(message.image)];
        }
        [videoObj setFlashURL:[NSURL URLWithString:message.videoUrl.videoUrl?:@""]];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:videoObj];
        sent = [QQApiInterface SendReqToQZone:req];
    }else{
        NSAssert(YES, @"message getType不支持");
    }
    
    if(sent != EQQAPISENDSUCESS)
    {
        DLog(@"not EQQAPISENDSUCESS");
    }
}

- (void)onReq:(QQBaseReq *)req
{
    DLog(@"直接从手Q回来:%@",req);
}

/**
 从手Q返回
 */
-(void)onResp:(QQBaseResp *)resp
{
    if(resp.result)
    {
        if([resp.result isEqualToString:@"0"])
        {
            //分享成功返回
            if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse:)])
            {
                [self.delegate onShareResponse:YES];
            }
            if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse2:)])
            {
                [self.delegate onShareResponse2:VDShareErrCodeNoErr];
            }
        }else if([resp.result isEqualToString:@"-4"])
        {
            //用户取消
            if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse:)])
            {
                [self.delegate onShareResponse:NO];
            }
            if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse2:)])
            {
                [self.delegate onShareResponse2:VDShareErrCodeUserCancel];
            }
        }
    }
}

-(void)isOnlineResponse:(NSDictionary *)response
{
    DLog(@"%@",response);
}

- (BOOL)onTencentReq:(TencentApiReq *)req
{
    if([self.delegate respondsToSelector:@selector(onShareRequest:respData:)])
    {
        [self.delegate onShareRequest:YES respData:[VDShareParamHelper getRespBase:share_resp_type]];
    }
    return YES;
    
}

- (BOOL)onTencentResp:(TencentApiResp *)resp
{
    if([self.delegate respondsToSelector:@selector(onShareResponse:)])
    {
        [self.delegate onShareResponse:YES];
    }
    if([self.delegate respondsToSelector:@selector(onShareResponse2:)])
    {
        [self.delegate onShareResponse2:VDShareErrCodeNoErr];
    }
    return YES;
}

-(BOOL)handleOpenUrl:(UIApplication *)app url:(NSURL *)url
{
#warning 这儿跟例子不一样，看看是否会有问题，copy例子的话，会导致没有办法接受返回值
    [QQApiInterface handleOpenURL:url delegate:self];
    [TencentOAuth HandleOpenURL:url];
    return YES;
}
@end
