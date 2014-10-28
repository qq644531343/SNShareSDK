//
//  SNShareResModel.h
//  SNShareSDK
//  资源模型，用于封装模块内部资源
//
//  Created by libo on 10/27/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNShareHeaders.h"

@interface SNShareResModel : NSObject

@property (nonatomic,strong) NSString *img;
@property (nonatomic,readwrite) SNShareDestination dest;
@property (nonatomic,strong) NSString *title;

@end
