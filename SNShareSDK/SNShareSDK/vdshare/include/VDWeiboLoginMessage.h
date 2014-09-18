//
//  微博SSO用户信息
//

#import <Foundation/Foundation.h>
//#import "VDLibGlobal.h"
#import "VDShareSynthesizeSingleton.h"
#import "WeiboSDK.h"
#import "VDWeiboCommon.h"

@interface VDWeiboLoginMessage : NSObject <NSCoding>
{
}
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDWeiboLoginMessage)

//微博官方SDK返回的用户信息
@property (nonatomic,copy) NSString *accessToken; //token
@property (nonatomic,copy) NSDate *expireDate;
@property (nonatomic,copy) NSString *scope;
@property (nonatomic,copy) NSString *uid;

@property (nonatomic,copy) NSString *screenName; //用户昵称
@property (nonatomic,copy) NSString *name; //友好显示名称
@property (nonatomic,copy) NSString *location; //用户所在地
@property (nonatomic,copy) NSString *description; //用户个人描述
@property (nonatomic,copy) NSString *url; //用户博客地址

@property (nonatomic,copy) NSString *face; //头像[50*50]
@property (nonatomic,copy) NSString *bigFace; //头像[180*180]
@property (nonatomic,copy) NSString *highFace; //高清头像
@property (nonatomic,copy) NSString *faceBackground; //用户背景

@property (nonatomic,assign) int followersCount; //粉丝数
@property (nonatomic,assign) int friendsCount; //关注数
@property (nonatomic,assign) int favouritesCount; //收藏数
@property (nonatomic,assign) BOOL verified; //是否是微博认证用户，即加V用户，true：是，false：否

//是否登录超时
- (BOOL) checkLoginExpire;
- (void) initWithLoginMessage:(VDWeiboLoginMessage *) mess;
- (void) initData;
@end
