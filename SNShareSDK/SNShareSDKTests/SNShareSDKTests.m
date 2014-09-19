//
//  SNShareSDKTests.m
//  SNShareSDKTests
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SNShareHeaders.h"

@interface SNShareSDKTests : XCTestCase<VDShareManagerDelegate, VDWeiboManagerLoginDelegate, WBHttpRequestDelegate>

@property (nonatomic, strong) SNShareModel *model;

@end

@implementation SNShareSDKTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.model = [[SNShareModel alloc] init];
    _model.title = @"测试标题";
    _model.description = @"测试内容描述";
    _model.image = [UIImage imageNamed:@"test.png"];
    _model.imgUrl = @"http://img0.bdstatic.com/img/image/shouye/hjmhhsxn1.jpg";
    _model.videoID = @"1";
    _model.url = @"http://video.sina.com.cn/app";
    
    VDShareVideoParam *videoParam = [[VDShareVideoParam alloc] init];
    videoParam.videoUrl = @"http://video.sina.com.cn/p/ent/z/v/2014-09-04/100064109055.html"; //视频h5地址
    _model.videoUrl = videoParam;

}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    self.model = nil;
    [super tearDown];
}

-(void)testAllShare
{

}


- (void)testExample
{
    XCTAssertTrue(1,"testEnd");
    //XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

@end
