//
//  ViewController.m
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "ViewController.h"
#import "SNShareHeaders.h"

@interface ViewController ()<SNShareDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"enterShare" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 200, 80, 50);
    [btn addTarget:self action:@selector(enterShareClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self SNShareDataSource];
    
}

-(void)enterShareClick
{
    SNShareShow(self)
}

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

@end
