//
//  SNShareView.m
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import "SNShareView.h"

@interface SNShareView ()

//@property (nonatomic,strong) 

@end

@implementation SNShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setDisplayType:(SNShareViewDisplayType)displayType
{
    _displayType = displayType;
}

@end
