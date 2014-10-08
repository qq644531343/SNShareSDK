
/*!
 @header    ALToastView.h
 @abstract  ToastView  类似安卓吐司效果
 @author    libo
 */

#import <Foundation/Foundation.h>

@interface ALToastView : UIView {
@private
	UILabel *_textLabel;
}

+ (ALToastView *)toastInView:(UIView *)parentView withText:(NSString *)text;

+ (ALToastView *)toastInView:(UIView *)parentView withText:(NSString *)text offSetY:(float)y;

+(void)setDuration:(float)dat;

+(void)enableRotaion:(BOOL)rotaion;


@end
