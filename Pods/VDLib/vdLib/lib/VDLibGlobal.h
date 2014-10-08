/*!
 @header VDLibGlobal
 @abstract 头部引用文件，
 @discussion 直接引用此文件包含VDLib，不是特殊情况，不要自己任意包含了
            请在lib目录下执行
            使用此脚本来同步头文件，不要手动添加，
            有问题联系sunxiao1@staff.sina.com.cn
 find . -name "*.h"|grep -v "VDLibGlobal"|grep -v "LZMASDK"|grep -v "VDPrefix.h"|awk -F'/' '{print "#import \""$NF"\""}'
 @author sunxiao1@staff.sina.com.cn
 */

#ifdef __OBJC__

#import "NSDateFormatter+VDFactory.h"
#import "NSDictionary+VDExtending.h"
#import "NSMutableDictionary+VDExtending.h"
#import "NSNull+VDSafety.h"
#import "NSString+VDChinese.h"
#import "NSString+VDUrl.h"
#import "UIColor+VDColor.h"
#import "UIImage+VDExtension.h"
#import "UIView+VDFunction.h"
#import "UIView+VDFrame.h"

#import "VDMacro.h"

#import "JSONKit.h"

#import "XLogDefine.h"

#import "ARCSynthesizeSingleton.h"
#import "SynthesizeSingleton.h"

#import "VDStopWatch.h"
#import "VDFileHelper.h"
#import "VDRandom.h"
#import "VDMathematicFunction.h"
#import "VDDeviceEventCenter.h"
#import "VDNetworkMonitor.h"
#import "VDRealTaskManager.h"
#import "SynthesizeSingleton.h"

#import "SystemUtil.h"
#import "SystemFunction.h"

#import "ALToastView.h"

#endif
