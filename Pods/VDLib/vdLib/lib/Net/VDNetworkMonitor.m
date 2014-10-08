#import <Reachability.h>
#import "VDNetworkMonitor.h"
#import "XLogDefine.h"

@interface VDNetworkMonitor ()

@property (nonatomic,retain) Reachability* reachability;

@end

@implementation VDNetworkMonitor
@synthesize networkType = _networkType;
@synthesize reachability = _reachability;

SYNTHESIZE_SINGLETON_FOR_CLASS(VDNetworkMonitor)

- (id) init
{
	self = [super init];
	if (self)
	{
        _networkType = [[Reachability reachabilityForInternetConnection] currentReachabilityStatus];
		_reachability = nil;
		[[NSNotificationCenter defaultCenter] addObserver: self
												 selector: @selector(reachabilityChanged:)
													 name: kReachabilityChangedNotification
												   object: nil];
	}
	return self;
}

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	self.reachability = nil;
	
	[super dealloc];
}

- (void) start
{
	if ([self isStarting])
	{
		return;
	}
    
	self.reachability = [Reachability reachabilityWithHostname:@"www.sina.com.cn"];
	[self.reachability startNotifier];
}

- (void) start:(float)delay
{
	[self performSelector:@selector(start) withObject:nil afterDelay:delay];
}

- (BOOL) isStarting
{
	return self.reachability != nil;
}

- (void) stop
{
	[self.reachability stopNotifier];
	self.reachability = nil;
}

- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
    if (curReach != self.reachability) {
        return;
    }
    
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    
	TNetworkType networkType = eNetworkNETNone;
	NetworkStatus reachableStatus = [curReach currentReachabilityStatus];
	switch (reachableStatus)
	{
		case NotReachable:
		{
			networkType = eNetworkNETNone;
			break;
		}
		case ReachableViaWWAN:
		{
			networkType = eNetworkNETwwan;
			break;
		}
		case ReachableViaWiFi:
		{
			networkType = eNetworkNETwifi;
			break;
		}
		default:
			NSAssert(NO, @"未知Reachable");
			break;
	}
	
	if (_networkType != networkType)
	{
		XLogD(@"current networkType: %d", (int)networkType);
		_networkType = networkType;
		[[NSNotificationCenter defaultCenter] postNotificationName:NETWORK_TYPE_NOTIFICATION_KEY
                                                            object:[NSNumber numberWithLong:_networkType]];
	}
}

@end
