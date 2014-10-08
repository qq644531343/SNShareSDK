/*!
 @header UIColor+VDColor.h
 @abstract 可以用整型来表示颜色
 */
#import <UIKit/UIKit.h>

#define RGBA(r,g,b,a)           \
        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/*!
 UIColor扩展
 */
@interface UIColor (VDColor)

/*!
 扩展，直接用0xFFFFFFFF表示颜色，带透明度方式
 @param argb 0xFFFFFFFF
 @return UIColor
 */
+ (UIColor*)colorWithARGB:(NSUInteger)argb;


/*!
 扩展，直接用0xFFFFFF表示颜色，alpha=1.0f
 @param rgb 0xFFFFFF
 @return UIColor
 */
+ (UIColor *)colorWithRGB:(NSUInteger)rgb;


/*!
 用0xFFFFFF表示颜色
 @param rgb 0xFFFFFFFF 
 @param alpha 0-1
 @return UIColor
 */
+ (UIColor*)colorWithRGB:(NSUInteger)rgb alpha:(CGFloat)alpha;

@end
