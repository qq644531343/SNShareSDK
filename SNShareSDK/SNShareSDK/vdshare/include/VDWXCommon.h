//
//  微信部分的宏定义以及基础类型
//

#ifndef VDShareDemo_eVDWXCommon_h
#define VDShareDemo_eVDWXCommon_h

//分享的类型
typedef enum {
    eVDWXShareTypeNone,
    eVDWXShareTypeLink, //纯连接
    eVDWXShareTypeImage, //纯图片
    eVDWXShareTypeText, //纯文字
} eVDWXShareType;


//分享文本类型，文本或者是多媒体
typedef enum {
    eVDWXMessageTypeNone,
    eVDWXMessageTypeMultimedia,
    eVDWXMessageTypeText,
} eVDWXMessageType;

//#define KVDWXAppID @"wx2faea841a8e0c605"
//#define kVDWXAppKey @"ede68279aeca2af223662c7d084297a6"

#endif
