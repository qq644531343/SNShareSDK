
/*!
 @header XLogDefine.h

 @abstract 打印不同颜色log
 
 @author zhouchen3@staff.sina.com.cn
 */

#import "XLogUtil.h"

#ifndef vdLib_XLogDefine_h
#define vdLib_XLogDefine_h

/*!
   日志输出:LOG_LEVEL=0 debug LOG_LEVEL=1 inhouse
   XLog:配合VDMonitorReporter的重定向输出，可以少量记录日志信息，在正式环境下使用
   XLogD:测试环境使用，正式关闭
   XLogI:测试环境使用，正式关闭
   XLogV:测试环境使用，正式关闭
   XLogE:测试环境使用，正式关闭

   @param fmt format
   @param ... 具体的数值
 */
#if defined (LOG_LEVEL)
#define XLog_log(tag, color, ...) _XLog_print(tag, color, __FILE__, __FUNCTION__, __LINE__, [NSString stringWithFormat:__VA_ARGS__])
#else
#define XLog_log(tag, color, ...)
#endif


#define XLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define XLogD(...) XLog_log(XLOG_LEVEL_DEBUG, XLOG_COLOR_RESET, __VA_ARGS__)
#define XLogI(...) XLog_log(XLOG_LEVEL_INFO, XLOG_COLOR_GREEN, __VA_ARGS__)
#define XLogV(...) XLog_log(XLOG_LEVEL_WARN, XLOG_COLOR_BLUE, __VA_ARGS__)
#define XLogE(...) XLog_log(XLOG_LEVEL_ERROR, XLOG_COLOR_RED, __VA_ARGS__)

#endif
