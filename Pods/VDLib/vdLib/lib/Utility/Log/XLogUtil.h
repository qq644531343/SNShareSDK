
/*!
 @header XLog.h
 
 @abstract 打印不同颜色log
 */

#import <Foundation/Foundation.h>

#define XLOG_ESC_CH @"\033"
#define XLOG_LEVEL_DEBUG    @"DEBUG"
#define XLOG_LEVEL_INFO     @"INFO"
#define XLOG_LEVEL_WARN     @"WARN"
#define XLOG_LEVEL_ERROR    @"ERROR"

// colors for log level, change it as your wish
#define XLOG_COLOR_RED   XLOG_ESC_CH @"#FF0000"
#define XLOG_COLOR_GREEN XLOG_ESC_CH @"#00FF00"
#define XLOG_COLOR_BROWN  XLOG_ESC_CH @"#FFFF00"
#define XLOG_COLOR_BLUE  XLOG_ESC_CH @"#0000FF"
#define XLOG_COLOR_ONLYME  XLOG_ESC_CH @"#00FFFF"
// hard code, use 00000m for reset flag
#define XLOG_COLOR_RESET XLOG_ESC_CH @"#00000m"   


#if defined (__cplusplus)
extern "C" {
#endif
    void _XLog_print(NSString *tag, NSString *colorStr, const char *fileName, const char *funcName, unsigned line, NSString *log);
    void _XLog_getFileName(const char *path, char *name);
    BOOL _XLog_isEnable();
#if defined (__cplusplus)
}
#endif
