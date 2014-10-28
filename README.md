SNShareSDK
==========

###功能描述：
该分享SDK支持的分享平台有：微博、朋友圈、微信好友、QQ空间、QQ好友。
实现了分享逻辑和UI的包装，考虑到主要用于视频App中，所以支持对SVPController的控制。


###分享工程配置指南：
1,  将snshare目录加入到你的工程中。

2,  添加如下Podfile项目:

pod 'VDShare', :svn => 'https://svn1.intra.sina.com.cn/sinavideo_app/ios/VideoDept_V2.0/VDShare'

pod 'VDLib', :svn => 'http://svn1.intra.sina.com.cn/sinavideo_app/ios/VideoDept_V2.0/VDLib'   
   
3,  找到工程的Info -> URL Types，添加对应的schema

![image](https://github.com/qq644531343/iosTool/blob/master/screenshot/shareConfigInfo.png)

`注意：由于第三方sdk目前不是完全兼容 x86_64，所以用模拟器iphone5s以上编译时无法通过，但真机调试/运行是没问题的！`

###代码编程指南：

1, 在AppDelegate中添加如下代码：

```
#import "SNShareHeaders.h"

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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //分享环境初始化
    SNSInit
    return YES;
}

@end


```


###使用
```
引入头文件#import "SNShareHeaders.h"
实现SNShareDelegate


#pragma mark - SNShareDelegate
-(SNShareModel *)SNShareDataSource
{
    SNShareModel *model = [[SNShareModel alloc] init];
    model.title = @"hello";
    model.description = @"world";
    model.image = [UIImage imageNamed:@"app.png"];
    model.imgUrl = @"http://img0.bdstatic.com/img/image/shouye/mxlyf-9632102318.jpg";
    model.videoID = @"1234";
    model.url = @"http://video.sina.com.cn/app";
    
    VDShareVideoParam *videoParam = [[VDShareVideoParam alloc] init];
    videoParam.videoUrl = @"http://video.sina.com.cn/app";
    model.videoParams = videoParam;

    
    NSError *error = [SNShareTool checkDataModel:model];
    DLog(@"%@",[error localizedDescription]);
    
    if (0 && error) {
        return nil;
    }else {
        return model;
    }
    
}

-(void)SNShareResponse:(VDShareErrCode)errCode Msg:(NSString *)msg
{
    DLog(@"%@",msg);
}

／／调用：
-(void)enterShareClick
{
    SNShareShow(self)
}


```

