//
//  UIView+FindSubview.m
//-Ipad
//
//  Created by  on 13-1-9.
//  Copyright (c) 2013年 . All rights reserved.
//

#import "UIView+VDFunction.h"

@implementation UIView (VDFunction)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)viewWithSelector:(SEL)aSelector
{
    for (UIView *aView in [self subviews])
    {
        if ([aView respondsToSelector:aSelector])
        {
            return aView;
        }
        else
        {
            UIView *candidateView = [aView viewWithSelector:aSelector];
            if (candidateView)
            {
                return candidateView;
            }
        }
    }
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

//////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end
