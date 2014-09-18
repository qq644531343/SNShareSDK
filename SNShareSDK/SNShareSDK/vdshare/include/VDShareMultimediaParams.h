//
//  附加的视频音频类
//
//  Created by sunxiao on 14-3-5.
//  Copyright (c) 2014年 sunxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VDShareVideoParam : NSObject <NSCoding>

@property (nonatomic,copy) NSString *videoUrl;
@property (nonatomic,copy) NSString *videoLowBandUrl;
@property (nonatomic,copy) NSString *videoStreamUrl;
@property (nonatomic,copy) NSString *videoLowBandStreamUrl;
@end

@interface VDShareAudioParam : NSObject <NSCoding>

@property (nonatomic,copy) NSString *audioWebUrl;
@property (nonatomic,copy) NSString *audioLowbandWebUrl;
@property (nonatomic,copy) NSString *audioStreamUrl;
@property (nonatomic,copy) NSString *audioLowBandStreamUrl;
@end
