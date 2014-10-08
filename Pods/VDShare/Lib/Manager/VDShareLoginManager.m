#import "VDShareLoginManager.h"

@implementation VDShareLoginManager

+ (VDWeiboLoginMessage *)getWeiboLoginMessage
{
    return [[VDWeiboManager sharedInstance] getLoginMessage];
}

+ (void)weiboLogin:(id<VDWeiboManagerLoginDelegate>)delegate
{
    [[VDWeiboManager sharedInstance] login:delegate];
}

+ (void)weiboLoginOut
{
    [[VDWeiboManager sharedInstance] loginOut];
}

+ (void)registerLogin
{
    [[VDWeiboManager sharedInstance] registerLogin];
}

@end
