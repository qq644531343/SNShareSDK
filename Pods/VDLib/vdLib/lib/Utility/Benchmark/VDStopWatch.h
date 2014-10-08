/*!
 @header VDStopWatch
 @abstract 插桩方式测速
            注：不要用在采用CFRunLoop或者多线程方式中，无法保证精度
 @discussion 例子：
            INIT_STOPWATCH(watch);
            //一堆语句
            LAP(watch, @"句子1");
            //又一堆语句
            LAP(watch, @"句子2");
 */
#import <Foundation/Foundation.h>
#import <sys/time.h>

/*!
 插桩方式测速，用来测试某段代码消耗的时长
 */
@interface VDStopWatch : NSObject
{
	struct timeval tv1, tv2;
}

/*!
 单例
 
 @return VDStopWatch
 */
+ (VDStopWatch* ) stopwatch;

/*!
 开始
 */
- (void) startWatch;

/*!
 加入自定义消息的开始，在每次start的时候，NSLog打出一行字
 @param message 那行字
 */
- (void) startWatch:(NSString*)message;

/*!
 输出message以及消耗时间
 @param message 那行字
 */
- (void) lap:(NSString*)message;

/*!
 获取stopwatch消耗时间
 @return double秒
 */
- (double) getRunningTime;

@end

#if (DEBUG != 0)
#	define STOCKWATCH 1
#else
#	define STOCKWATCH 0
#endif

#if (STOCKWATCH != 0)
/*!
  宏：INIT_STOPWATCH(watch)
 */
#  define INIT_STOPWATCH(s) VDStopWatch *s = [VDStopWatch stopwatch]
/*!
 宏：LAP(watch,@"那行字")
 */
#  define LAP(s, msg) [s lap:msg]
#else
#  define INIT_STOPWATCH(s) 
#  define LAP(s, msg) 
#endif
