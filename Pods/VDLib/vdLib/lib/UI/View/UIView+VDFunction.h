
/*!
 @header UIView+FindSubview.h
 
 @abstract UIView Category
 */

#import <UIKit/UIKit.h>

@interface UIView (VDFunction)

/*!
  Removes all subviews.
 */
- (void)removeAllSubviews;

/*!
  找出View的viewController
 */
- (UIViewController*)viewController;
/*!
  查找respondToSelector:aSelector的某个子view，找不到时返回nil
 */
- (UIView *)viewWithSelector:(SEL)aSelector;

@end
