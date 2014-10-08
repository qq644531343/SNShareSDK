//
//  MathematicFunction.m
//  vdLib
//
//  Created by zhouchen on 14-9-18.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#import "VDMathematicFunction.h"

@implementation VDMathematicFunction

+ (NSUInteger)MBlogCountWords:(NSString *)text
{
    NSUInteger n = [text length], l = 0, a = 0, b = 0;
    unichar c;
    
    for(int i = 0; i < n; i++){
        c = [text characterAtIndex:i];
        if(isblank(c)){
            b++;
        }else if(isascii(c)){
            a++;
        }else{
            l++;
        }
    }
    if(a==0 && l==0) return 0;
    
    return l+(int)ceilf((float)(a+b)/2.0);
}

+ (double)Norm_rand:(double)miu sigma2:(double)sigma2
{
    if (sigma2 <= 0 || miu <= 0) {
        return 0;
    }
    
    double N = 12;
    double x=0,temp=N;
    
    x=0;
    for(int i=0;i<N;i++) {
        x=x+(1.0*rand()/NSIntegerMax);
    }
    x=(x-temp/2)/(sqrt(temp/12));
    x=miu+x*sqrt(sigma2);
    
    if (x < 0) {
        x = 0;
    }
    
    return x;
}

//判断是否为整形：
+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

//格式化TB,GB,MB,KB,Bytes
+ (NSString *)sizeFormat:(long long)bytes
{
    long long byte = bytes;
    int i = 0;
    
    while (byte >= 1024)
    {
        byte = byte / 1024;
        i ++;
        
        if (i == 4) break;
    }
    
    NSArray *array = [NSArray arrayWithObjects:
                      @"B",
                      @"K",
                      @"M",
                      @"G",
                      @"T", nil];
    
    NSString *string = [NSString stringWithFormat:@"%lld%@", byte, [array objectAtIndex:i]];
    
    return string;
}

@end
