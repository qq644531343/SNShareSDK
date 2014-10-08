//
//  VDDeviceEventCenter.m
//  VDLib
//
//  Created by sunxiao on 2014-2-27.
//  Copyright (c) 2011年 sina. All rights reserved.
//

#import "VDDeviceEventCenter.h"
#import "VDLibGlobal.h"

NSString *const kOrientationFromKey = @"OrientationFromKey";
NSString *const kOrientationToKey = @"OrientationToKey";

#define kDelayDuration 1.2f

@interface CDelegateProxy : NSObject
{
}

@property (nonatomic,assign) UIInterfaceOrientation interfaceOrientation;
@property (nonatomic,assign) id<VDDeviceEventDelegate> delegate;

- (id) initWithDelegate:(id<VDDeviceEventDelegate>)delegate;

@end


@implementation CDelegateProxy
@synthesize interfaceOrientation = _interfaceOrientation;
@synthesize delegate = _delegate;

- (id) initWithDelegate:(id<VDDeviceEventDelegate>)delegate
{
	self = [super init];
	if (self)
	{
		self.interfaceOrientation = 0;
		self.delegate = delegate;
	}
	return self;
}

- (void) dealloc
{
	self.delegate = nil;
	[super dealloc];
}

@end

@interface VDDeviceEventCenter ()
{
	struct timeval _lastUpdate;
}

@property (nonatomic,retain) NSMutableArray* delegates;

- (void) putDT;
- (float) getDT;
- (UIInterfaceOrientation) getNewOrientation:(UIInterfaceOrientation)oldOrientation;
- (CGAffineTransform) getAffineTransformBy:(UIInterfaceOrientation)orientation;

- (void) changeProxy:(CDelegateProxy*)proxy interfaceOrientation:(UIInterfaceOrientation)newOrientation;

@end

@implementation VDDeviceEventCenter
@synthesize interfaceOrientation = _interfaceOrientation;
@synthesize initializeInterfaceOrientation = _initializeInterfaceOrientation;
@synthesize delegates = _delegates;

static VDDeviceEventCenter* _defaultCenter = nil;
+ (VDDeviceEventCenter *) defaultCenter
{
	if (!_defaultCenter)
	{
		_defaultCenter = [[VDDeviceEventCenter alloc] init];
	}
	return _defaultCenter;
}

+ (id)alloc
{
	NSAssert(_defaultCenter == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

+ (void) purgeDefaultCenter
{
	[_defaultCenter release];
	_defaultCenter = nil;
}

- (id) init
{
	self = [super init];
	if (self)
	{
		self.delegates = [NSMutableArray arrayWithCapacity:1];
		
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        
		[[NSNotificationCenter defaultCenter] addObserver:self 
												 selector:@selector(uideviceOrientationDidChange:)
													 name:UIDeviceOrientationDidChangeNotification
												   object:nil];
		self.initializeInterfaceOrientation = UIInterfaceOrientationPortrait;
		_interfaceOrientation = UIInterfaceOrientationPortrait;
		[self putDT];
	}
	return self;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wall"
- (void) putDT
{
	gettimeofday(&_lastUpdate, NULL);
}
#pragma clang diagnostic pop

- (float) getDT
{
	float dt = 0.0f;
	struct timeval now;
	if( gettimeofday( &now, NULL) != 0 )
	{
		dt = 0;
		return dt;
	}
	
	dt = (now.tv_sec - _lastUpdate.tv_sec) + (now.tv_usec - _lastUpdate.tv_usec) / 1000000.0f;
	dt = MAX(0,dt);
	
	_lastUpdate = now;
	return dt;
}

- (UIInterfaceOrientation) getNewOrientation:(UIInterfaceOrientation)oldOrientation
{
	UIInterfaceOrientation newOrientation = oldOrientation;
	switch ([UIDevice currentDevice].orientation)
	{
		case UIDeviceOrientationPortrait:
			if (newOrientation != UIInterfaceOrientationPortrait)
			{
				newOrientation = UIInterfaceOrientationPortrait;
			}
			break;
			
		case UIDeviceOrientationPortraitUpsideDown:
			if (newOrientation != UIInterfaceOrientationPortraitUpsideDown)
			{
				newOrientation = UIInterfaceOrientationPortraitUpsideDown;
			}
			break;
			
		case UIDeviceOrientationLandscapeLeft:
			if (newOrientation != UIInterfaceOrientationLandscapeRight)
			{
				newOrientation = UIInterfaceOrientationLandscapeRight;
			}
			break;
			
		case UIDeviceOrientationLandscapeRight:
			if (newOrientation != UIInterfaceOrientationLandscapeLeft)
			{
				newOrientation = UIInterfaceOrientationLandscapeLeft;
			}
			break;
			
		case UIDeviceOrientationFaceUp:
		case UIDeviceOrientationFaceDown:
		case UIDeviceOrientationUnknown:
		default:
			break;
	}
	return newOrientation;
}

- (void) uideviceOrientationDidChange:(NSNotification *)notif
{
	XLogD(@"device orientation did changed: %@", notif);
	BOOL ret = YES;
	id v = [[notif userInfo] valueForKey:@"UIDeviceOrientationRotateAnimatedUserInfoKey"];
	if ([v respondsToSelector:@selector(intValue)])
	{
		ret = [v intValue];
	}
	else if ([v respondsToSelector:@selector(description)])
	{
		ret = [[v description] intValue];
	}
	if (!ret) 
	{
		return;
	}
	
	_interfaceOrientation = [self getNewOrientation:_interfaceOrientation];
	if ([self getDT] < kDelayDuration)
	{
		XLogD(@"cancel Device Orientation Changed");
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delayUIDeviceOrientationChangedEvent) object:nil];
		[self performSelector:@selector(delayUIDeviceOrientationChangedEvent) withObject:nil afterDelay:kDelayDuration];
		return;
	}
	[self putDT];

	for (CDelegateProxy* proxy in self.delegates)
	{
		UIInterfaceOrientation newOrientation = [self getNewOrientation:proxy.interfaceOrientation];
		[self changeProxy:proxy interfaceOrientation:newOrientation];
	}
}

- (void) delayUIDeviceOrientationChangedEvent
{
	[self uideviceOrientationDidChange:nil];
}

- (CDelegateProxy*) getProxyBy:(id<VDDeviceEventDelegate>)delegate
{
	CDelegateProxy* p = nil;
	for (CDelegateProxy* proxy in self.delegates)
	{
		if (proxy.delegate == delegate)
		{
			p = proxy;
			break;
		}
	}
	return p;
}

- (UIInterfaceOrientation) interfaceOrientation:(id<VDDeviceEventDelegate>)delegate
{
	CDelegateProxy* proxy = [self getProxyBy:delegate];
	return [proxy interfaceOrientation];
}

- (CGAffineTransform) transform:(id<VDDeviceEventDelegate>)delegate
{
	CDelegateProxy* proxy = [self getProxyBy:delegate];
	return [self getAffineTransformBy:[proxy interfaceOrientation]];
}

- (CGAffineTransform) transform
{
	return [self getAffineTransformBy:_interfaceOrientation];
}

- (CGAffineTransform) getAffineTransformBy:(UIInterfaceOrientation)orientation
{
	CGAffineTransform t = CGAffineTransformIdentity;
	if (orientation == UIDeviceOrientationPortrait)
	{
		t = CGAffineTransformIdentity;
	}
	else if (orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        t = CGAffineTransformMakeRotation(M_PI);
    }
    else if (orientation == UIInterfaceOrientationLandscapeRight)
    {
		t = CGAffineTransformMakeRotation(M_PI / 2.0);
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft)
    {
		t = CGAffineTransformMakeRotation(-M_PI / 2.0);
    }
	return t;
}

- (void) addDelegate:(id<VDDeviceEventDelegate>)delegate
{
	CDelegateProxy* proxy = [[CDelegateProxy alloc] initWithDelegate:delegate];
	proxy.interfaceOrientation = self.initializeInterfaceOrientation;
	[self.delegates addObject:proxy];
	[proxy release];
}

- (void) removeDelegate:(id<VDDeviceEventDelegate>)delegate
{
	for (CDelegateProxy* proxy in self.delegates)
	{
		if (proxy.delegate == delegate)
		{
			[self.delegates removeObject:proxy];
			break;
		}
	}
}

- (void) changeProxy:(CDelegateProxy*)proxy interfaceOrientation:(UIInterfaceOrientation)newOrientation
{
	if (newOrientation != proxy.interfaceOrientation)
	{
		if ([proxy.delegate shouldAutorotateToInterfaceOrientation:newOrientation])
		{
			if ([proxy.delegate respondsToSelector:@selector(willRotateFromT:toT:userInfo:)])
			{
				NSDictionary* userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
										  [NSNumber numberWithInt:proxy.interfaceOrientation], 
										  kOrientationFromKey,
										  [NSNumber numberWithInt:newOrientation], 
										  kOrientationToKey, 
										  nil];
				[proxy.delegate willRotateFromT:[self getAffineTransformBy:proxy.interfaceOrientation]
											toT:[self getAffineTransformBy:newOrientation]
									   userInfo:userInfo];
			}
			else if ([proxy.delegate respondsToSelector:@selector(willRotateFromO:toO:)])
			{
				[proxy.delegate willRotateFromO:proxy.interfaceOrientation toO:newOrientation];
			}
			proxy.interfaceOrientation = newOrientation;
		}
	}
}

- (void) changeInterfaceOrientation:(UIInterfaceOrientation)newOrientation
{
	for (CDelegateProxy* proxy in self.delegates)
	{
		[self changeProxy:proxy interfaceOrientation:newOrientation];
	}
}

- (void) dealloc
{
	self.delegates = nil;
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
	[super dealloc];
}

@end
