//
//  SNShareWindow.h
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNShareDelegate.h"

@interface SNShareWindow : UIWindow
{
    id<SNShareDelegate> _shareDelegate;
}

+(SNShareWindow *)sharedSNShareWindow;

-(void)showWindowWithDelegate:(id<SNShareDelegate>) shareDelegate;

@end
