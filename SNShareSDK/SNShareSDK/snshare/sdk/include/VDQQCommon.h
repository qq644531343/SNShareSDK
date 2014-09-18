//
//  手Q以及Qzone基础类型
//

#ifndef VDShareDemo_VDQQCommon_h
#define VDShareDemo_VDQQCommon_h

//#define kVDQQAppID @"101027235"
//#define kVDQQAppKey @"8046ef8fa3dd91f302a14601e6975a03"

typedef enum {
    eVDQQMessageTypeUnknown, //默认值，用了这个是不会分享出去的
    eVDQQMessageTypeText, //分享文字，就一段话，没有连接 --手Q支持
    eVDQQMessageTypeImage, //分享图片，没有连接 --手Q支持
    eVDQQMessageTypeNews, //分享带本地图片的资讯类型***用的最多的 --手Q、QZone支持
    eVDQQMessageTypeAudio, //分享音频 --手Q、QZone支持
    eVDQQMessageTypeVideo, //分享视频 --手Q、QZone支持
} eVDQQMessageType;

#endif
