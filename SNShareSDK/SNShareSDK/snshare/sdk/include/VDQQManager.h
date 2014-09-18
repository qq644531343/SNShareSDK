//
//  手Q以及Qzone管理类
//


#import <Foundation/Foundation.h>
//#import <TencentOpenAPI/QQApi.h>
//#import <TencentOpenAPI/TencentApiInterface.h>
//#import <TencentOpenAPI/TencentOAuth.h>
//#import <TencentOpenAPI/QQApiInterface.h>
//#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <QQApi.h>
#import <TencentApiInterface.h>
#import <TencentOAuth.h>
#import <QQApiInterface.h>
#import <QQApiInterfaceObject.h>

#import "VDShareParam.h"
#import "VDShareSynthesizeSingleton.h"
#import "VDShareMacro.h"
#import "VDShareCommon.h"

@interface VDQQManager : NSObject <TencentApiInterfaceDelegate,QQApiInterfaceDelegate,TencentSessionDelegate>
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDQQManager)

@property (nonatomic,retain) id<VDShareManagerDelegate> delegate;

//注册
- (void) registerApp;

- (void)sendMessageToUsers:(VDQQMessage *)message delegate:(id<VDShareManagerDelegate>) delegate;
- (void)sendMessageToQzone:(VDQQMessage *)message delegate:(id<VDShareManagerDelegate>) delegate;

//注册到appdelegate里面
-(BOOL)handleOpenUrl:(UIApplication *)app url:(NSURL *)url;

@end
