
/*!
 @header        VDMacro.h
 @abstract      所有通用的宏定义
 @author        zhouchen3@staff.sina.com.cn
 */

#ifndef vdLib_VDMarco_h
#define vdLib_VDMarco_h


/*!
 @abstract SHOWMACOR 将一个宏转为字符串，可以用类似：NSLog(@"%@",[NSString stringWithUTF8String:SHOWMACOR(名字)]);方法来输出
 @author sunxiao
 */
#define SHOW_MACOR(x)            #x

/*!
 @abstract 安全字符串
 @author   zhouchen3
 */
#define SAFE_STRING(x)           \
        (x&&[x isKindOfClass:[NSString class]])?x:([x isKindOfClass:[NSNumber class]]?[x description]:@"")

/*!
 @abstract 安全对象
 @author   zhouchen3
 */
#define SAFE_OBJECT(x)           \
        ( ((x) == [NSNull null] || (x) == nil) ? nil : (x) )


#pragma mark - 软件更新和用户评分的链接地址


#define APPSTORE_UPGRATE_FORMAT  \
        @"http://itunes.apple.com/cn/app/id%@?mt=8"

/*!
 @abstract APP的itunes下载地址
 @author   zhouchen3
 */
#define APPSTORE_UPGRATE(AppID)  \
        [NSString stringWithFormat:APPSTORE_UPGRATE_FORMAT, AppID]

#define APPSTORE_RATING_FORMAT   \
        @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8"

/*!
 @abstract APP的itunes评分地址
 @author   zhouchen3
 */
#define APPSTORE_RATING(AppID)  \
        [NSString stringWithFormat:APPSTORE_RATING_FORMAT, AppID]


#pragma mark - 版本号比较（3位）

/*!
 @abstract  三位版本号相等（==）
 @author zhouchen3
 */
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedSame)

/*!
 @abstract  三位版本号相等（>）
 @author zhouchen3
 */
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedDescending)

/*!
 @abstract  三位版本号相等（>=）
 @author zhouchen3
 */
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedAscending)

/*!
 @abstract  三位版本号相等（<）
 @author zhouchen3
 */
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]==NSOrderedAscending)

/*!
 @abstract  三位版本号相等（<=）
 @author zhouchen3
 */
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch]!=NSOrderedDescending)


#pragma mark - UI层次宏

/*!
 @abstract 获取KeyWindow的快捷宏
 @author  zhouchen3
 */
#define APP_KEY_WINDOW          [[UIApplication sharedApplication] keyWindow]

/*!
 @abstract 获取RootController的快捷宏
 @author  zhouchen3
 */
#define APP_ROOT_CONTROLLER     [[[[UIApplication sharedApplication] delegate] window] rootViewController]

/*!
 @abstract 屏幕宽度
 @author  zhouchen3
 */
#define SCREEN_WIDTH            [SystemUtil screenBounds].size.width

/*!
 @abstract 屏幕高度
 @author  zhouchen3
 */
#define SCREEN_HEIGHT           [SystemUtil screenBounds].size.height


#endif
