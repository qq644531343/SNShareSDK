
/*!
 @header    UIImage+VDExtension
 @abstract  提供对图片的裁剪、缩放、旋转、创建等功能
 @author    libo
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <AssetsLibrary/AssetsLibrary.h>

@interface UIImage (VDExtension)

CGFloat VDDegreesToRadians(CGFloat degrees);
CGFloat VDRadiansToDegrees(CGFloat radians);

#pragma mark - 裁剪

/*!
 裁减
 @param rect 裁减区域
 @return UIImage
 */
- (UIImage *)imageAtRect:(CGRect)rect;


#pragma mark - 缩放
/*!
 等比例缩放
 @param size 新尺寸
 @return UIImage
 */
- (UIImage *)scaleToSize:(CGSize)size;

/*!
 直接放缩，非等比例
 @param targetSize 放缩大小
 @return UIImage
 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;

/*!
    缩放图片
    @param contentMode 填充方式
    @param bounds      新图片尺寸
    @param quality     图片质量
 */
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

/*!
  将图片缩小到一定的大小 微博,微信sdk传递的数据会用到
 */

- (UIImage *)clipImageToFitMaxSize:(float)maxSize;


#pragma mark - 旋转

/*!
 按角度旋转【角度值】
 @param degrees 角度值
 @return UIImage
 @discussion 如若需要按弧度值旋转，可使用 VDRadiansToDegrees(radians) 将弧度转角度后再传参
 */
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;


#pragma mark - 生成Image

/*!
 图片叠加
 @param image1 图1[底层]
 @param image2 图2[上层]
 @return UIImage
 */
+ (UIImage *)addImage:(UIImage *)image1 toImage:(UIImage *)image2;

/*!
 生成指定颜色的图片
 @param  color 颜色对象
 @return UIImage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

#pragma mark - 修改Image
/*!
 生成指定颜色的图片
 @param bgColor      背景色
 @return UIImage
 */
- (UIImage *) imageWithBackgroundColor:(UIColor *)bgColor
                           shadeAlpha1:(CGFloat)alpha1
                           shadeAlpha2:(CGFloat)alpha2
                           shadeAlpha3:(CGFloat)alpha3
                           shadowColor:(UIColor *)shadowColor
                          shadowOffset:(CGSize)shadowOffset
                            shadowBlur:(CGFloat)shadowBlur;

/*!
 相册方式添加图像
 @param failureBlock
 */
- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata customAlbumName:(NSString *)customAlbumName completionBlock:(void (^)(void))completionBlock failureBlock:(void (^)(NSError *error))failureBlock;

@end
