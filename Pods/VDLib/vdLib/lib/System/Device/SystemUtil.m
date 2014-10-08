//
//  SystemUtil.m
//  subway
//
//  Created by zhouchen on 14-8-6.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#import "SystemUtil.h"
#import "getddidsdk.h"
#import "UIDeviceHardware.h"

@implementation SystemUtil

+ (id)sharedInstance
{
    static SystemUtil *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SystemUtil alloc] init];
    });
    return instance;
}

- (NSString *)appVersion
{
    static NSString *appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    });
    return appVersion;
}

- (NSString *)appBuild
{
    static NSString *appVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    });
    return appVersion;
}

- (NSString *)appVersion_Build
{
    static NSString *appVersion_Build;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appVersion_Build = [NSString stringWithFormat:@"%@.%@", [self appVersion], [self appBuild]];
    });
    return appVersion_Build;
}

- (NSString *)systemVersion
{
    static NSString *systemVersion;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        systemVersion = [[UIDevice currentDevice] systemVersion];
    });
    return systemVersion;
}

- (NSString *)deviceID
{
    static NSString *deviceID;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        deviceID = [getddidsdk DeviceId];
    });
    return deviceID;
}

- (NSString *)Did
{
    static NSString *Did;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Did = [getddidsdk Did];
    });
    return Did;
}

- (NSString *)platform
{
    static NSString *platform;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platform = [UIDeviceHardware platform];
    });
    return platform;
}

- (NSString *)platformString
{
    static NSString *platformString;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        platformString = [UIDeviceHardware platformString];
    });
    return platformString;
}


- (CGRect)screenBounds
{
    static CGRect screenBounds;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        screenBounds = [[UIScreen mainScreen ] bounds];
    });
    return screenBounds;
}

- (BOOL)isIphone
{
    static BOOL isIphone;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIphone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    });
    return isIphone;
}

- (BOOL)isIphone5
{
    static BOOL isIphone5;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIphone5 = [self isIphone] && ([self screenBounds].size.height >= 568.0f? YES:NO);
    });
    return isIphone5;
}

- (BOOL)isIOS7
{
    static BOOL isIOS7;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isIOS7 = [[UIDevice currentDevice].systemVersion floatValue]>=7.0;
    });
    return isIOS7;
}

- (NSString *)documentPath
{
    static NSString *documentPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    });
    return documentPath;
}

- (NSString *)libraryPath
{
    static NSString *libraryPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    });
    return libraryPath;
}

- (NSString *)temporaryPath
{
    static NSString *temporaryPath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        temporaryPath = NSTemporaryDirectory();
    });
    return temporaryPath;
}

- (NSString *)cachePath
{
    static NSString *cachePath;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    });
    return cachePath;
}


@end
