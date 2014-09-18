//
//  SNShareHeaders.h
//  SNShareSDK
//
//  Created by libo on 9/18/14.
//  Copyright (c) 2014 sina. All rights reserved.
//

#ifndef SNShareSDK_SNShareHeaders_h
#define SNShareSDK_SNShareHeaders_h

#import "VDShareGlobal.h"
#import "VDShareConfig.h"
#import "SNShareManager.h"

#define SNSInit {[[SNShareManager sharedSNShareManager] shareConditionInit];}
#define SNSHandle(app,url) {[[SNShareManager sharedSNShareManager] handleOpenUrl:app url:url];}

#endif
