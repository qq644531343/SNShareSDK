/*!
 @header VDRandom
 @abstract 随机数包装类
           注：如果选择init:YES，表示重新选择随机种子，可能导致重复
 */
#import <Foundation/Foundation.h>


@interface VDRandom : NSObject{
    
}

/*!
 初始化
 */
+ (void) initRandom;

/*!
 最小值为0，最大值为maxNum
 @param maxNum 上限
 @param yesOrNo 是否从头开始
 @return int
 */
+ (int) getRandomNum:(int)maxNum init:(BOOL)yesOrNo;

/*!
 最小值为min，最大值为max
 @param minNum  最小值
 @param maxNum  最大值
 @param yesOrNo 是否从头开始
 @return int
 */
+ (int) getRandomNum:(int)minNum max:(int)maxNum init:(BOOL)yesOrNo;

/*!
 最小值为0，最大值为maxNum，默认将当前种子初始化，从头开始
 @param maxNum 最大值
 @return int
 */
+ (int) getRandomNum:(int)maxNum;

/*!
 最小值为min，最大值为max，默认将当前种子初始化，从头开始
 @param minNum  最小值
 @param maxNum  最大值
 @return int
 */
+ (int) getRandomNum:(int)minNum max:(int)maxNum;

@end
