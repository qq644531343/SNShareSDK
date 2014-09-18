//
//  文件操作部分基础函数
//

#import <Foundation/Foundation.h>
#import "VDShareFileBundle.h"

typedef unsigned long long TFileSize;

@interface VDShareFileHandle : NSObject
{
	NSFileHandle* _fileHandle;
}

//得到临时目录
+(NSString *) getAppTempPath;

//得到document目录
+(NSString *) getAppDocumentPath;

//得到cache目录
+ (NSString*) getAppCachePath;

//创建fileHandle以只读方式
+ (id) fileHandleForReadAtPath:(NSString*)path;
//创建fileHandle以只写方式
+ (id) fileHandleForWriteAtPath:(NSString*)path;
//删除指定文件
+ (BOOL) removeFileAtPath:(NSString*)path;
//判断是否存在文件
+ (BOOL) containFileAtPath:(NSString*)path;
//将文件拷贝到指定目录
+ (BOOL) copyFile:(NSString*)srcFilePath to:(NSString*)destFilePath;
//取得文件Size
+ (TFileSize) getFileSize:(NSString*)path;
//删除指定文件夹下面的扩展名为ext的所有文件
+ (void) removeFilesAtDirPath:(NSString*)path ext:(NSString*)ext;
//取得指定文件夹下面的所有文件Name
+ (NSArray*) getContentsbyDir:(NSString*)path;
//取得指定文件的modification日期
+ (NSDate*) getFileModificationDate:(NSString*)path;
//重命名
+ (BOOL) rename:(NSString*)srcFilePath to:(NSString*)destFilePath;

//将data完全写入文件
+ (BOOL) writeData:(NSData*)data toPath:(NSString*)path;
//将文件中的内容完全读出
+ (NSData*) readDataFromPath:(NSString*)path;

+ (BOOL) createPath:(NSString*)path;
+ (BOOL)createDirectoryForFilePath:(NSString *)filePath;

//在文件末尾添加data
- (void) appendData:(NSData*)data;
//向文件中写入data
- (void) writeData:(NSData*)data;
//在当前position读出data
- (NSData*) readData;

@end
