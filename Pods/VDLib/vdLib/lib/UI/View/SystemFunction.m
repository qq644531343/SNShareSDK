//
//  SystemFunction.m
//  vdLib
//
//  Created by zhouchen on 14-9-18.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#import "SystemFunction.h"

@implementation SystemFunction

+ (void)removeKeyboard
{
    //NSDate *date = [NSDate date];
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView *view = [self findKeyboardInView:window];
    if (view) {
        [view resignFirstResponder];
    }
    //NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:date];
}

+ (UIView *)findKeyboardInView:(UIView *)view
{
    for (UIView *subView in [view subviews])
    {
        //NSLog(@"%@", [subView class]);
        if ([subView isKindOfClass:[UITextField class]] || [subView isKindOfClass:[UITextView class]]) {
            if ([subView isFirstResponder]) {
                return subView;
            }
        }
        UIView *view = [self findKeyboardInView:subView];
        if (view) {
            return view;
        }
    }
    return nil;
}

@end
