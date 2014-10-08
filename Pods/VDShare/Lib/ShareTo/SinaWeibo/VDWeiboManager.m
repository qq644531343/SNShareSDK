#import "VDWeiboManager.h"
#import "VDWeiboCommon.h"
#import "JSONKit.h"
#import "VDShareLoginManager.h"
#import "VDShareHelper.h"
#import "VDShareAppInfoUtil.h"

@interface NSDictionary (DictionaryExtending)
- (BOOL)hasValueForKey:(NSString *)key;
- (int)intValueForKey:(NSString *)key;
@end

@implementation NSDictionary(DictionaryExtending)

- (BOOL)hasValueForKey:(NSString *)key
{
    
    BOOL hasValue = FALSE;
    if (key)
    {
        if ([self valueForKey:key])
        {
            hasValue = TRUE;
        }
    }
    
    return hasValue;
}

- (int)intValueForKey:(NSString *)key
{
    int intValue = 0;
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object respondsToSelector:@selector(intValue)])
        {
            intValue = [object intValue];
        }
    }
    return intValue;
}

@end

@implementation VDWeiboManager
@synthesize delegate = _delegate,loginDelegate = _loginDelegate;
SYNTHESIZE_SINGLETON_FOR_CLASS(VDWeiboManager)

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
    self.delegate = nil;
    self.loginDelegate = nil;
    [super dealloc];
}

- (void)registerApp
{
    DLog(@"WeiboSDK registerApp");
    [WeiboSDK enableDebugMode:YES];
//    [WeiboSDK registerApp:kWeiboAppKey];
    [WeiboSDK registerApp:[VDShareAppInfoUtil sharedInstance].weiboAppKey];
//    if([VDWeiboLoginMessage sharedInstance] == nil)
//    {
//        [VDWeiboLoginMessage purgeSharedInstance];
//        VDWeiboLoginMessage *message = [[VDLoginCache sharedInstance] getWeiboLoginMessage];
//        [[VDWeiboLoginMessage sharedInstance] initWithLoginMessage:message];
//    }
}

- (void)registerLogin
{
    if(![[VDWeiboLoginMessage sharedInstance] checkLoginExpire])
    {
        VDWeiboLoginMessage *cacheMessage = [[[VDLoginCache sharedInstance] getWeiboLoginMessage] retain];
        [[VDWeiboLoginMessage sharedInstance] initWithLoginMessage:cacheMessage];
        [cacheMessage release];
    }
}

#pragma mark 微博返回

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    DLog(@"WeiboSDK didReceiveWeiboRequest");
    if([request isKindOfClass:WBProvideMessageForWeiboRequest.class] && self.delegate != nil && [self.delegate respondsToSelector:@selector(onShareRequest:respData:)])
    {
        [self.delegate onShareRequest:YES respData:[VDShareParamHelper getRespBase:share_resp_type]];
    }
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    DLog(@"didReceiveWeiboResponse");
    NSAssert(response!=nil, @"response为nil");
    if(response.statusCode != WeiboSDKResponseStatusCodeSuccess)
    {
        DLog(@"didReceiveWeiboResponse返回错误");
        XLog(@"didReceiveWeiboResponse返回错误,code:%d",response.statusCode);
        return;
    }
    if([response isKindOfClass:[WBSendMessageToWeiboResponse class]])
    {
        //分享返回
        if(response.requestUserInfo == nil || ![response.requestUserInfo hasValueForKey:kVDWeiboManagerKey])
        {
            return;
        }
        if([[response.requestUserInfo objectForKey:kVDWeiboManagerKey] isEqualToString:@"VDWeiboManager"])
        {
            if(response.statusCode == 0 && [self.delegate respondsToSelector:@selector(onShareResponse:)])
            {
                [self.delegate onShareResponse:YES];
            }
            if([self.delegate respondsToSelector:@selector(onShareResponse2:)])
            {
                [self.delegate onShareResponse2:VDShareErrCodeNoErr];
            }
        }
    }else if([response isKindOfClass:[WBAuthorizeResponse class]]){
        //登录返回
        @try {
            if([(WBAuthorizeResponse *) response statusCode] == WeiboSDKResponseStatusCodeSuccess)
            {
                WBAuthorizeResponse *weiboResp = (WBAuthorizeResponse *) response;
                VDWeiboLoginMessage *message = [VDWeiboLoginMessage sharedInstance];
                message.accessToken = [weiboResp accessToken];
                message.uid = [weiboResp userID];
                message.expireDate = [weiboResp expirationDate];
                //附加的信息
                [self appendExtUserData:message];
                
                //取得用户背景？？
                //同步到缓冲文件
                [[VDLoginCache sharedInstance] syncWeiboLoginMessage:message];
                if([self.loginDelegate respondsToSelector:@selector(onWeiboManagerSuccessLogin)])
                {
                    [self.loginDelegate onWeiboManagerSuccessLogin];
                }
            }else{
                if([self.loginDelegate respondsToSelector:@selector(onWeiboManagerFailLogin)])
                {
                    [self.loginDelegate onWeiboManagerFailLogin];
                }
            }
        }
        @catch (NSException *exception) {
            return;
        }
        
    }
    else{
        NSAssert(YES, @"不是分享回馈，可能是登录审核请求");
    }
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    //出错就不管了，头像跟关注数不对而已
}

- (void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    //有url返回，但可能不对。。。
    DLog(@"didReceiveResponse:%@",response);
}

#warning 这儿需要重构下，太大了
-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSDictionary *dict = [result objectFromJSONString];
    if([[dict allKeys] containsObject:@"error"])
    {
        NSString *errCode = [dict objectForKey:@"error"];
        //加入错误处理部分
        if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse:)])
        {
            [self.delegate onShareResponse:NO];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse2:)])
        {
            if([errCode isEqualToString:@"10013"])
            {
                //不合法的微博用户，一般都是登录失效
                [self.delegate onShareResponse2:VDShareErrCodeUserTokenErr];
            }else{
                [self.delegate onShareResponse2:VDShareErrCodeSendErr];
            }
        }
        return;
    }
    BOOL resultOK = NO;
    @try {
        NSString *result = [dict objectForKey:@"result"];
        if([result isEqualToString:@"true"])
        {
            resultOK = YES;
        }
    }
    @catch (NSException *exception) {
    }
    if(resultOK)
    {
        //好吧，看意思，似乎这就代表退出成功了。
        if([self.loginDelegate respondsToSelector:@selector(onWeiboManagerLogout)])
        {
            [self.loginDelegate onWeiboManagerLogout];
        }
        return;
    }
    if([[dict allKeys] containsObject:@"annotations"])
    {
        //暂时认为发送图片微博成功
#warning 这个地方需要处理下，不知道为什么，发送到api的元数据返回为空？？？
        if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse:)])
        {
            [self.delegate onShareResponse:YES];
        }
        if(self.delegate && [self.delegate respondsToSelector:@selector(onShareResponse2:)])
        {
            [self.delegate onShareResponse2:VDShareErrCodeNoErr];
        }
        return;
    }
    
    VDWeiboLoginMessage *message = [VDWeiboLoginMessage sharedInstance];
    if([dict objectForKey:@"screen_name"])
    {
        message.screenName = [dict objectForKey:@"screen_name"];
    }
    if([dict objectForKey:@"name"])
    {
        message.name = [dict objectForKey:@"name"];
    }
    if([dict objectForKey:@"location"])
    {
        message.location = [dict objectForKey:@"location"];
    }
    if([dict objectForKey:@"description"])
    {
        message.description = [dict objectForKey:@"description"];
    }
    if([dict objectForKey:@"url"])
    {
        message.url = [dict objectForKey:@"url"];
    }
    if([dict objectForKey:@"profile_image_url"])
    {
        message.face = [dict objectForKey:@"profile_image_url"];
    }
    if([dict objectForKey:@"avatar_large"])
    {
        message.bigFace = [dict objectForKey:@"avatar_large"];
    }
    if([dict objectForKey:@"avatar_hd"])
    {
        message.highFace = [dict objectForKey:@"avatar_hd"];
    }
    if([dict objectForKey:@"followers_count"])
    {
        message.followersCount = [dict intValueForKey:@"followers_count"];
    }
    if([dict objectForKey:@"friends_count"])
    {
        message.friendsCount = [dict intValueForKey:@"friends_count"];
    }
    if([dict objectForKey:@"favourites_count"])
    {
        message.favouritesCount = [dict intValueForKey:@"favourites_count"];
    }
    if([dict objectForKey:@"verified"])
    {
        int verifiedInt = [dict intValueForKey:@"verified"];
        if(verifiedInt == 0)
        {
            message.verified = NO;
        }else if(verifiedInt == 1)
        {
            message.verified = YES;
        }
    }
    if([dict objectForKey:@"cover_image_phone"])
    {
        message.faceBackground = [dict objectForKey:@"cover_image_phone"];

    }
    
    [[VDLoginCache sharedInstance] syncWeiboLoginMessage:message];
    if([self.delegate respondsToSelector:@selector(onWeiboManagerSuccessLogin)])
    {
        [self.loginDelegate onWeiboManagerSuccessLogin];
    }
}

#pragma mark 用户登录部分
//取得用户头像
- (void)appendExtUserData:(VDWeiboLoginMessage *)message
{
    NSString *url = @"https://api.weibo.com/2/users/show.json";
    NSDictionary *params = @{@"access_token": message.accessToken,
                             @"uid": message.uid};
    [WBHttpRequest requestWithAccessToken:message.accessToken url:url httpMethod:@"GET" params:params delegate:self withTag:kWeiboUserOpenAPI];
}

- (BOOL) checkTokenValid:(id<VDShareManagerDelegate>) delegate
{
    NSAssert(delegate != nil, @"delegate is nil");
    if(![self getTokenInfo])
    {
        if([delegate respondsToSelector:@selector(onShareResponse2:)])
        {
            [delegate onShareResponse2:VDShareErrCodeAuthDeny];
        }
        if([delegate respondsToSelector:@selector(onShareResponse:)])
        {
            [delegate onShareResponse:NO];
        }
        [[VDWeiboLoginMessage sharedInstance] initData];
        [[VDLoginCache sharedInstance] removeWeiboLoginMessage];
        [[NSNotificationCenter defaultCenter] postNotificationName:__VDSHAREHELPERWEIXINOBNAME object:nil];
        return NO;
    }
    return YES;
}

- (void)login:(id<VDWeiboManagerLoginDelegate>) delegate
{
    NSAssert(delegate != nil, @"delegate为nil");
    self.loginDelegate = delegate;
    WBAuthorizeRequest *req = [WBAuthorizeRequest request];
    req.redirectURI = [VDShareAppInfoUtil sharedInstance].weiboRedirectUrl;
    req.scope = kWeiboScope;
    req.userInfo = @{kVDWeiboManagerKey:kVDWeiboLoginManager};
    
    [WeiboSDK sendRequest:req];
}

- (VDWeiboLoginMessage *)getLoginMessage
{
    VDWeiboLoginMessage *message = [VDWeiboLoginMessage sharedInstance];
    
    if(!message.checkLoginExpire)
    {
        return nil;
    }
    return message;
}

- (void)loginOut
{
    [WeiboSDK logOutWithToken:[VDWeiboLoginMessage sharedInstance].accessToken delegate:self withTag:kWeiboUserLoginOutTag];
    [[VDLoginCache sharedInstance] removeWeiboLoginMessage];
    [VDWeiboLoginMessage purgeSharedInstance];
}

#pragma mark 分享部分

- (WBMessageObject *) messageToShare:(VDWeiboMessage *)message
{
    WBMessageObject *ret = [WBMessageObject message];
    if(message.type == eVDWeiboMessageTypeText)
    {
        ret.text = message.text;
    }else if(message.type == eVDWeiboMessageTypeImage)
    {
        WBImageObject *img = [WBImageObject object];
        img.imageData = UIImagePNGRepresentation(message.imageOrThumbnail);
        ret.imageObject = img;
    }else if(message.type == eVDWeiboMessageTypeUrl)
    {
        WBWebpageObject *webpage = [WBWebpageObject object];
        webpage.objectID = @"identifier1";
        webpage.title = message.webTitle;
        webpage.description = message.webDesc;
        webpage.thumbnailData = UIImagePNGRepresentation(message.imageOrThumbnail);
        webpage.webpageUrl = message.webUrl;
        ret.mediaObject = webpage;
    }else if(message.type == eVDWeiboMessageTypeVideo)
    {
        WBVideoObject *videoObj = [WBVideoObject object];
        videoObj.videoUrl = message.videoUrl.videoUrl;
        videoObj.videoLowBandUrl = message.videoUrl.videoLowBandUrl;
        videoObj.videoStreamUrl = message.videoUrl.videoStreamUrl;
        videoObj.videoLowBandStreamUrl = message.videoUrl.videoLowBandStreamUrl;
        ret.mediaObject = videoObj;
    }else if(message.type == eVDWeiboMessageTypeAudio)
    {
        WBMusicObject *musicObj = [WBMusicObject object];
        musicObj.musicUrl = message.audioUrl.audioWebUrl;
        musicObj.musicLowBandUrl = message.audioUrl.audioLowbandWebUrl;
        musicObj.musicStreamUrl = message.audioUrl.audioStreamUrl;
        musicObj.musicLowBandStreamUrl = message.audioUrl.audioLowBandStreamUrl;
        ret.mediaObject = musicObj;
    }
    return ret;
}

/*!
 直接用openapi方式发送 <br />
 只能使用status字段进行填写<br />
 低级接口，无数量限制：https://api.weibo.com/2/statuses/update.json<br />
 
 @param message
 */
- (void) sendBaseOpenAPIMessage:(VDWeiboMessage *)message
{
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/update.json"];
    NSString *method = @"POST";
    NSString *token = [[VDWeiboManager sharedInstance] getLoginMessage].accessToken;
    NSString *status = [NSString stringWithFormat:@"%@%@",message.webDesc,[message.videoUrl.videoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *annotations = [[NSArray arrayWithObjects:@"1024", nil] JSONString];
    NSDictionary *params = @{@"access_token":(token==nil?@"":token),@"status":(status==nil?@"":status),@"annotations":(annotations==nil?@"":annotations)};
    
    [WBHttpRequest requestWithAccessToken:token url:url httpMethod:method params:params delegate:self withTag:kWeiboSendMessageOpenAPI];
}

/*!
 直接用openapi方式发送<br />
 只能使用status字段进行填写
 
 <font color="#FF0000">与sendBaseOpenAPIMessage行为一致，原来用做图片接口的</font>
 @param message
 */
- (void) sendAdvOpenAPIMessage:(VDWeiboMessage *)message
{
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/update.json"];
    NSString *method = @"POST";
    NSString *token = [[VDWeiboManager sharedInstance] getLoginMessage].accessToken;
    NSString *status = [NSString stringWithFormat:@"%@%@",message.webDesc,[message.videoUrl.videoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSString *status = [NSString stringWithFormat:@"%@",message.webDesc];

    NSString *annotations = [[NSArray arrayWithObjects:@"annotations", nil] JSONString];
    NSDictionary *params = @{@"access_token":token,@"status":status,@"annotations":annotations};
    
    [WBHttpRequest requestWithAccessToken:token url:url httpMethod:method params:params delegate:self withTag:kWeiboSendMessageAdvOpenAPI];
}

/*!
 发送多图的接口
 
 @param message
 */
- (void) sendMultiPicMessage:(VDWeiboMessage *)message
{
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/2/statuses/upload_url_text.json"];
    NSString *method = @"POST";
    NSString *token = [[VDWeiboManager sharedInstance] getLoginMessage].accessToken;
    NSString *status = [NSString stringWithFormat:@"%@%@",message.webDesc,[message.videoUrl.videoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    NSString *annotations = [[NSArray arrayWithObjects:@"annotations", nil] JSONString];
    NSMutableString *picID = [NSMutableString stringWithCapacity:1];
    for(NSString *value in message.picIDArr)
    {
        [picID appendString:[NSString stringWithFormat:@"%@,",value]];
    }
    //去掉最后的逗号
//    if(![picID isEqualToString:@""])
//    {
//        picID = (NSMutableString *)[picID substringToIndex:picID.length - 2];
//    }
    
    NSDictionary *params = @{@"access_token":token,@"status":status,@"annotations":annotations,@"pic_id":picID};
    
    [WBHttpRequest requestWithAccessToken:token url:url httpMethod:method params:params delegate:self withTag:kWeiboSendMessageMultiPicOpenAPI];
}

- (BOOL) getTokenInfo
{
    VDWeiboLoginMessage *message = [self getLoginMessage];
    if(!message)
    {
        return NO;
    }
    
    NSString *url = [NSString stringWithFormat:@"https://api.weibo.com/oauth2/get_token_info"];
    NSString *token = message.accessToken;
    
    NSString *params = [NSString stringWithFormat:@"access_token=%@",token];
    
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:nsUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    [request release];
    
    NSString *retStr = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSDictionary *retDict = [retStr objectFromJSONString];
    if([retDict hasValueForKey:@"error"])
    {
        return NO;
    }
    
    return YES;
}



- (void)sendMessage:(VDWeiboMessage *)message delegate:(id<VDShareManagerDelegate>)delegate
{
    NSAssert(delegate != nil, @"delegate为nil");
    if(![self checkTokenValid:delegate])
    {
        return;
    }
    
    message.webUrl = [VDShareHelper getPureUrlWithUrl:message.webUrl guestAppType:eSinaWeibo];
    self.delegate = delegate;
    
    //增加直接使用openapi方式进行发送微博的接口
    if(message.type == eVDWeiboMessageTypeOpenAPI)
    {
        [self sendBaseOpenAPIMessage:message];
    }else if(message.type == eVDWeiboMessageTypeAdvOpenAPI){
        [self sendAdvOpenAPIMessage:message];
    }else if(message.type == eVDWeiboMessageTypeMultiPicOpenAPI){
        [self sendMultiPicMessage:message];
    }else{
        if([WeiboSDK isWeiboAppInstalled])
        {
            WBSendMessageToWeiboRequest *req = [WBSendMessageToWeiboRequest requestWithMessage:[self messageToShare:message]];
            req.userInfo = @{kVDWeiboManagerKey:@"VDWeiboManager"};
            
            [WeiboSDK sendRequest:req];
        }else{
            //未安装的情况，直接用OPENAPI方式打开
            [self sendBaseOpenAPIMessage:message];
        }
    }
}

-(BOOL)handleOpenUrl:(UIApplication *)app url:(NSURL *)url
{
    DLog(@"WeiboSDK handleOpenURL");
    [WeiboSDK handleOpenURL:url delegate:self];
    return YES;
}

@end
