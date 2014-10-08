//
//  NSNull+StringEquals.m
//-Ipad
//
//  Created by yuanliang on 14-9-25.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "NSNull+VDSafety.h"
#import "XLogDefine.h"

@implementation NSNull (VDSafety)

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([self respondsToSelector:[invocation selector]]) {
        [invocation invokeWithTarget:self];
    }else{
        NSString *selectorStr = NSStringFromSelector([invocation selector]);
        XLogV(@"NSNull doesNotRecognizeSelector:%@",selectorStr);
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature *sig = [[NSNull class] instanceMethodSignatureForSelector:selector];
    if(sig == nil) {
        sig = [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
    }
    return sig;
}

@end
