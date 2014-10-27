//
//  SNShareWindow.m
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "SNShareWindow.h"

@implementation SNShareWindow

static SNShareWindow *instance = nil;
+(SNShareWindow *)sharedSNShareWindow
{
    if (instance == nil) {
        @synchronized(instance){
            if (instance == nil) {
                instance = [[SNShareWindow alloc] init];
            }
        }
    }
    return instance;
}


-(void)showWindowWithDelegate:(id)shareDelegate
{
    _shareDelegate = shareDelegate;
}


-(void)dismissWindow
{
    _shareDelegate = nil;
}

@end
