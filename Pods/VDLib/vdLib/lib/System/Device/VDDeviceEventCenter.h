/*!
 *  @header         VDDeviceEventCenter
 *  @abstract       自定义的转屏类
 *  @discussion     可以脱离当前的viewcontroller的方式实现在任意位置控制转屏触发动作
 *                  缺陷：速度可能稍慢，后期优化
 *  @author         sunxiao1@staff.sina.com.cn
 */

#import <Foundation/Foundation.h>

//#define kMessageAppWillReturnToFirstPage @"kMessageAppWillReturnToFirstPage"
static const NSString *kMessageAppWillReturnToFirstPage = @"kMessageAppWillReturnToFirstPage";

@protocol VDDeviceEventDelegate;
@interface VDDeviceEventCenter : NSObject
{
}

@property (nonatomic,readonly) UIInterfaceOrientation interfaceOrientation;
@property (nonatomic,readonly) CGAffineTransform transform;
@property (nonatomic,assign) UIInterfaceOrientation initializeInterfaceOrientation;

+ (VDDeviceEventCenter *) defaultCenter;
+ (void) purgeDefaultCenter;

- (UIInterfaceOrientation) interfaceOrientation:(id<VDDeviceEventDelegate>)delegate;
- (CGAffineTransform) transform:(id<VDDeviceEventDelegate>)delegate;

- (void) addDelegate:(id<VDDeviceEventDelegate>)delegate;
- (void) removeDelegate:(id<VDDeviceEventDelegate>)delegate;

- (void) changeInterfaceOrientation:(UIInterfaceOrientation)newOrientation;

@end


@protocol VDDeviceEventDelegate <NSObject>

@required
- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@optional
- (void) willRotateFromT:(CGAffineTransform)from toT:(CGAffineTransform)to userInfo:(NSDictionary*)userInfo;
- (void) willRotateFromO:(UIInterfaceOrientation)from toO:(UIInterfaceOrientation)to;

@end

extern NSString *const kOrientationFromKey;
extern NSString *const kOrientationToKey;

