SNShareSDK
==========

###分享工程配置指南：
1,  将snshare目录加入到你的工程中。

2,  添加如下系统库:

![image](https://github.com/qq644531343/iosTool/blob/master/screenshot/share.png)

3,  将目录中TencentOpenApi.framework拖到Build Phases -> Libarary中
确保Build Phases -> Resource中含有TencentOpenApi_iOS_Bundle.bundle文件

4,  找到工程的Build Settings -> Search Paths，确保含有如下信息：
	
	    		
    	* Framework Search Path栏含有  $(PROJECT_DIR)/SNShareSDK/snshare/res
		* Header Search Path栏含有：
		    "$(SRCROOT)/SNShareSDK/snshare/sdk/include"
		    "$(SRCROOT)/SNShareSDK/snshare/sdk/res/TencentOpenAPI.framework/Headers"
		* Library Search Path含有："$(SRCROOT)/SNShareSDK/snshare/sdk"
	
	其中SNShareSDK为你工程目录名，路径为你的相对路径即可，确保含有上述项目即可。
      
5,  找到工程的Info -> URL Types，添加对应的schema

![image](https://github.com/qq644531343/iosTool/blob/master/screenshot/shareConfigInfo.png)

`注意：由于第三方sdk目前不是完全兼容 x86_64，所以用模拟器iphone5s以上编译时无法通过，但真机调试/运行是没问题的！`

###代码编程指南：

1, 在AppDelegate中添加如下代码：

```
//
//  AppDelegate.m
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "AppDelegate.h"
#import "SNShareHeaders.h"

@implementation AppDelegate

#pragma mark - share handle

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    SNSHandle(application,url);
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //分享回调
    SNSHandle(application,url);
    
    return YES;
}

#pragma mark - main

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //分享环境初始化
    SNSInit
    
    return YES;
}


@end


```





