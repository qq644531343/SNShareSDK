//
//  VDStopWatch.m
//  VDLib
//
//  Created by on 11-9-10.
//  Copyright 2011年 . All rights reserved.
//

#import "VDStopWatch.h"


@implementation VDStopWatch

+ (VDStopWatch*) stopwatch
{
    return [[[VDStopWatch alloc] init] autorelease];
}

- (id) init
{
	self = [super init];
	if (self)
	{
		gettimeofday(&tv1, NULL);
	}
	return self;
}

- (void) startWatch
{
	gettimeofday(&tv1, NULL);
}

- (void) startWatch:(NSString*)message
{
#if (STOCKWATCH != 0)
	if (message != nil)
	{
		NSLog(@"watch: <%@>", message);
	}
	gettimeofday(&tv1, NULL);
#endif
}

- (void) lap:(NSString*)message
{
#if (STOCKWATCH != 0)
    gettimeofday(&tv2, NULL);
	
    uint64_t sec = tv2.tv_sec - tv1.tv_sec;
    uint64_t diff = sec * 1000 * 1000 + (tv2.tv_usec - tv1.tv_usec);
    
    NSLog(@"%@ (<cast>%lld.%06lld)", message, diff / 1000000, diff % 1000000);
#endif
}

- (double) getRunningTime
{
    gettimeofday(&tv2, NULL);
	
    uint64_t sec = tv2.tv_sec - tv1.tv_sec;
    uint64_t diff = sec * 1000 * 1000 + (tv2.tv_usec - tv1.tv_usec);
    
    return ((int)(diff/1000000) + (diff % 1000000)/1000000.0);
}


- (void) dealloc
{
	[super dealloc];
}

@end
