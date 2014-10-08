#import "VDLoginCache.h"
#import "VDWeiboManager.h"
#import "VDWeiboLoginMessage.h"
#import "VDShareFileHandle.h"
#import "VDShareMacro.h"

@implementation VDLoginCache
SYNTHESIZE_SINGLETON_FOR_CLASS(VDLoginCache)

- (NSString *)getWeiboLoginCachePath
{
    NSString *path = [NSString stringWithFormat:@"%@/%@",[VDShareFileHandle getAppCachePath],kVDWeiboLoginCacheFilename];
    return path;
}

- (void)removeWeiboLoginMessage
{
    NSString *path = [self getWeiboLoginCachePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
}

- (void)syncWeiboLoginMessage:(VDWeiboLoginMessage *)message
{
    if(!message)
    {
        DLog(@"message is nil");
        return;
    }
    NSString *path = [self getWeiboLoginCachePath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    }
    NSData *messageData = [NSKeyedArchiver archivedDataWithRootObject:message];
    [messageData writeToFile:path atomically:YES];
}

- (VDWeiboLoginMessage *)getWeiboLoginMessage
{
    @try {
        NSString *path = [self getWeiboLoginCachePath];
        if([[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            NSData *loginData = [NSData dataWithContentsOfFile:path];
            if(loginData)
            {
                VDWeiboLoginMessage* message = [NSKeyedUnarchiver unarchiveObjectWithData:loginData];
                if(message)
                {
//                    [[VDWeiboManager sharedInstance] appendExtUserData:message];
                    return message;
                }
            }
        }
    }
    @catch (NSException *exception) {
        DLog(@"%@",exception);
    }
    
    return nil;
}

@end
