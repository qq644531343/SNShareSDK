//
//  VDRealTaskManager.m
//  VDLib
//
//  Created by sunxiao on 14-2-27.
//  Copyright (c) 2012年 sina. All rights reserved.
//

#import "VDRealTaskManager.h"
#import <QuartzCore/CoreAnimation.h>

@interface VDRealTask ()

@property (nonatomic,assign) int frameCumulative;
@property (nonatomic,assign) BOOL complete;

@end

@implementation VDRealTask
@synthesize target = _target;
@synthesize action = _action;
@synthesize duration = _duration;
@synthesize cast = _cast;
@synthesize frameRate = _frameRate;
@synthesize params = _params;
@synthesize frameCumulative = _frameCumulative;
@synthesize complete = _complete;
@synthesize endAction=_endAction;
@synthesize interval=_interval;
@synthesize flag = _flag;

+ (id) realTask
{
	return [[[self alloc] init] autorelease];
}

- (id) init
{
	self = [super init];
	if (self)
	{
		self.duration = 0.0f;
		self.cast = 0.0f;
		self.complete = NO;
		self.frameCumulative = 0;
		self.frameRate = 1;
        self.duration=0.f;
		_params = [[NSMutableDictionary alloc] init];
	}
	return self;
}

- (void) dealloc
{
	self.target = nil;
	self.action = nil;
    self.endAction = nil;
	[_params release];
	[super dealloc];
}

@end


@interface VDRealTaskManager ()

@property (nonatomic,retain) NSMutableArray* tasks;
@property (nonatomic,assign) CADisplayLink* displayLink;
@property (nonatomic,assign) BOOL paused;

- (void) startTimer;
- (void) stopTimer;

@end


@implementation VDRealTaskManager
@synthesize framesPerSecond = _framesPerSecond;
@synthesize tasks = _tasks;
@synthesize displayLink = _displayLink;
@synthesize paused = _paused;

static VDRealTaskManager* _sharedTaskManager = nil;
+ (VDRealTaskManager *) sharedTaskManager
{
	if (!_sharedTaskManager)
	{
		_sharedTaskManager = [[VDRealTaskManager alloc] init];
	}
	return _sharedTaskManager;
}

+ (void) purgeSharedTaskManager
{
	[_sharedTaskManager release];
	_sharedTaskManager = nil;
}

- (id) init
{
	self = [super init];
	if (self)
	{
		self.framesPerSecond = 60;
		self.tasks = [NSMutableArray arrayWithCapacity:1];
		self.displayLink = nil;
		self.paused = NO;
	}
	return self;
}

- (void) setFramesPerSecond:(NSUInteger)framesPerSecond
{
	if (framesPerSecond > 60)
	{
		framesPerSecond = 60;
	}
	if (framesPerSecond == 0)
	{
		framesPerSecond = 1;
	}
	_framesPerSecond = framesPerSecond;
}

- (void) addTask:(VDRealTask*)task
{
	NSAssert(task != nil, @"参数错误");
	task.frameCumulative = 0;
	task.cast = 0.0f;
    task.interval=0.f;
	[self.tasks addObject:task];
	[self startTimer];
}

//add by alexsun
- (void) removetaskFromFlag:(int) flag
{
    NSAssert(flag != 0, @"参数错误");
    for(VDRealTask *task in self.tasks)
    {
        if(task.flag == flag)
        {
            [self removeTask:task];
            [self.displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            self.displayLink = nil;
        }
    }
}

- (void) removeTask:(VDRealTask*)task
{
	NSAssert(task != nil, @"参数错误");
	task.frameCumulative = 0;
	task.cast = 0.0f;
    task.interval=0.f;
	[self.tasks removeObject:task];
	if ([self.tasks count] == 0)
	{
		[self stopTimer];
	}
}

- (NSArray*) allTasks
{
	return self.tasks;
}

- (NSUInteger) taskCount
{
	return [self.tasks count];
}

- (void) clearTasks
{
	[self.tasks removeAllObjects];
	[self stopTimer];
}

- (void) startTimer
{
	if (self.paused) return;
	if (self.displayLink != nil) return;

	self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(timeElapsed)];
	self.displayLink.frameInterval = 60 / self.framesPerSecond;
	[self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void) stopTimer
{
	[self.displayLink invalidate];
	self.displayLink = nil;
}

- (void) timeElapsed
{
	for (VDRealTask* task in self.tasks)
	{
		task.cast += self.displayLink.duration;
        task.interval = self.displayLink.duration;
		task.frameCumulative += 1;
		
		if (task.frameCumulative >= task.frameRate && task.target != nil && task.action != nil)
		{
			task.frameCumulative = 0;
			[task.target performSelector:task.action withObject:task afterDelay:0.0f];
		//	[task.target performSelector:task.action withObject:task];
		}
		
		if (task.cast >= task.duration)
		{
            if(task.target !=nil && task.endAction!=nil)
            {
                [task.target performSelector:task.endAction withObject:task afterDelay:0.0f];
            }
			task.complete = YES;
		}
	}
	
	for (int i = (int)[self.tasks count] - 1; i >= 0; i --)
	{
		VDRealTask* task = [self.tasks objectAtIndex:i];
		if (task.complete)
		{
			[self.tasks removeObjectAtIndex:i];
		}
	}
	
	if ([self.tasks count] == 0)
	{
		[self stopTimer];
	}
}

- (void) pause
{
	self.paused = YES;
	[self stopTimer];
}

- (void) resume
{
	self.paused = NO;
	[self startTimer];
}

- (void) dealloc
{
	[self stopTimer];
	
	self.tasks = nil;
	[super dealloc];
}

@end
