//
//  SNShareView.h
//  SNShareSDK
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

typedef enum SNShareViewDisplayType
{
    SNShareViewDisplayTypeUnknown,
    SNShareViewDisplayTypeSmall,  //小屏
    SNShareViewDisplayTypeFull    //全屏
}SNShareViewDisplayType;

#import <UIKit/UIKit.h>
#import "SNShareManager.h"

@interface SNShareView : UIView

-(instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic,readwrite) SNShareViewDisplayType displayType;


@end
