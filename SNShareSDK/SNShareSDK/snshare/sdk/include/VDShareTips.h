//
//  微信等分享，要求从微信等客户端打开的页面，需要在当前页面中显示相关的“返回到微信”tips
//

#import <UIKit/UIKit.h>

@interface VDShareTips : UIView
{
}

@property (nonatomic,retain) UIImage *backgroundImg;

- (void) setContentAndRefresh:(NSString *) str;

@end
