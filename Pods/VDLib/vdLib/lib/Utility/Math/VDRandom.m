//
//  VDRandom.m
//
//  Created by on 10-9-26.
//  Copyright 2010. All rights reserved.
//

#import "VDRandom.h"


@implementation VDRandom

+ (void) initRandom
{
	srand((int)time(0)+rand());
}

+ (int) getRandomNum:(int)maxNum
{
	return [self getRandomNum:maxNum init:YES];
}

+ (int) getRandomNum:(int)minNum max:(int)maxNum
{
	return [self getRandomNum:minNum max:maxNum init:YES];
}

+ (int) getRandomNum:(int)maxNum init:(BOOL)yesOrNo
{
	if (maxNum <= 0) return 0;
	
	if (yesOrNo) srand((int)time(0)+rand());
	return abs(rand()) % (maxNum + 1);
}

+ (int) getRandomNum:(int)minNum max:(int)maxNum init:(BOOL)yesOrNo
{
	if (maxNum <= 0) return 0;
	if (minNum >= maxNum) return maxNum;
	
	if (yesOrNo) srand((int)time(0)+rand());
	return (abs(rand()) % (maxNum - minNum + 1) + minNum);
}

@end
