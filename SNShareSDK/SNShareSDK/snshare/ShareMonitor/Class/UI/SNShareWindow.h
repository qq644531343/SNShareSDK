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

@property (nonatomic,weak) id<SNShareDelegate> shareDelegate;


+(SNShareWindow *)sharedSNShareWindow;

-(void)showWindowWithDelegate:(id<SNShareDelegate>) shareDelegate;

@end
