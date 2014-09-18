//
//  VDMarco.h
//  vdLib
//
//  Created by adanchou on 14-1-8.
//  Copyright (c) 2014年 sina. All rights reserved.
//

#ifndef vdLib_VDMarco_h
#define vdLib_VDMarco_h

// 安全释放
#define VD_RELEASE_SAFELY(__POINTER) if(__POINTER){[__POINTER release];__POINTER=nil;}

//检测字符串为空
#define VDNSSTRING_ISEMPTY(str) (str == nil || [str isEqual:[NSNull null]] || str.length <= 0)

//测试环境下使用的日志输出
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

//正式环境下使用的日志输出
#define XLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);

//版本部分的判断
#ifndef NSFoundationVersionNumber_iOS_6_0
#define NSFoundationVersionNumber_iOS_6_0  993.00
#endif
#ifndef NSFoundationVersionNumber_iOS_6_1
#define NSFoundationVersionNumber_iOS_6_1  993.00
#endif
#ifndef NSFoundationVersionNumber_iOS_7_0
#define NSFoundationVersionNumber_iOS_7_0  1047.00
#endif

#define iOS7SDK	(__IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1)

#define currentOSVersion (floor(NSFoundationVersionNumber))

//当前版本判断.
#define isiOS5	((currentOSVersion >= NSFoundationVersionNumber_iOS_5_0) && (currentOSVersion <= NSFoundationVersionNumber_iOS_5_1))
#define isiOS6	((currentOSVersion > NSFoundationVersionNumber_iOS_5_1) && (currentOSVersion <= NSFoundationVersionNumber_iOS_6_1))
#define isiOS7	(currentOSVersion >= NSFoundationVersionNumber_iOS_7_0)

#endif
