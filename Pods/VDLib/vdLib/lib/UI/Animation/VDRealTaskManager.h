/*!
 @header VDRealTaskManager
 @abstract CADisplayLink管理类，在自定义逐帧动画的时候使用
 @discussion <VDRealTaskManager> sample:
 //初始化
 VDRealTaskManager *realTasks = [VDRealTaskManager sharedTaskManager];
 [realTasks clearTasks];
 //添加一个任务进去
 VDRealTask* realTask = [VDRealTask realTask];
 realTask.duration = 0.2f; //持续0.2秒
 realTask.frameRate = 1;
 realTask.target = self;
 //绘制一帧动画
 realTask.action = @selector(handleKlineAnimate:);
 //动画结束时候调用
 realTask.endAction=@selector(endKlineAnimate:);
 //传入的自定义参数
 [realTask.params setValue:[NSNumber numberWithInt:CKlineGestureViewEndAnimationValue] forKey:CKlineGestureViewEndAnimationKey];
 [realTask.params setValue:[NSNumber numberWithInt:range.length] forKey:CKlineGestureViewEndAnimationLength];
 [realTask.params setValue:[NSNumber numberWithInt:range.location] forKey:CKlineGestureViewEndAnimationLoc];
 [[CRealTaskManager sharedTaskManager] addTask:realTask];
 
 //基本的动画动作
 -(void) handleKlineAnimate:(id)sender
 {
    VDRealTask *task=(VDRealTask *)sender;
    if(task)
    {
        int loc=0;
        unsigned int length=0;
        //得到初始化时候传入的参数
        loc=[[task.params valueForKey:CKlineGestureViewEndAnimationLoc] intValue];
        //刷一帧
        [self setNeedsDisplay];
    }
 }
 */
#import <Foundation/Foundation.h>

/*!
 一个任务
 */
@interface VDRealTask : NSObject
{
}

/*!
 目标
 */
@property (nonatomic,assign) id target;

/*!
 每次触发时候，执行的动作
 */
@property (nonatomic,assign) SEL action;				//- (void) tick:(VDRealTask*)task;
/*!
 触发结束执行的动作
 */
@property (nonatomic,assign) SEL endAction;

/*!
 持续时间，单位（秒）
 */
@property (nonatomic,assign) float duration;

/*!
 一共用掉的时间
 */
@property (nonatomic,assign) float cast;

/*!
 本次动画用到的时间
 */
@property (nonatomic,assign) float interval;

/*!
 间隔
 */
@property (nonatomic,assign) NSUInteger frameRate;

/*!
 参数部分
 */
@property (nonatomic,readonly) NSMutableDictionary* params;
@property (nonatomic,assign) int flag;

/*!
 单例
 @return VDRealTask
 */
+ (id) realTask;

@end

/*!
 任务管理器
 */
@interface VDRealTaskManager : NSObject
{
}

/*!
 每秒帧数
 */
@property (nonatomic,assign) NSUInteger framesPerSecond;

/*!
 单例
 
 @return VDRealTaskManager
 */
+ (VDRealTaskManager *) sharedTaskManager;

/*!
 销毁单例
 */
+ (void) purgeSharedTaskManager;

/*!
 添加
 @param task VDRealTask
 */
- (void) addTask:(VDRealTask*)task;

/*!
 删除
 @param flag 添加task的时候的Flag,int方式标示符
 */
- (void) removetaskFromFlag:(int) flag;

/*!
 删除
 @param task 指针方式参数
 */
- (void) removeTask:(VDRealTask*)task;

/*!
 返回当前运行的所有的Task
 @return
 */
- (NSArray*) allTasks;

/*!
 当前运行的所有Task数
 @return
 */
- (NSUInteger) taskCount;

/*!
 清除所有
 */
- (void) clearTasks;

/*!
 暂停
 */
- (void) pause;

/*!
 重新开始
 */
- (void) resume;

@end
