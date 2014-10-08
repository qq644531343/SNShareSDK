
/*!
 @header       VDFileHelper.h
 @abstract     只提供复杂的文件操作，简单的操作直接使用NSFileManager
 @author       zhouchen3@staff.sina.com.cn
 */

#import <Foundation/Foundation.h>

@interface VDFileHelper : NSObject

/*!
 创建文件夹并设置iCloud属性
 @param folderPath      路径
 @param iCloudEnable    iCloud属性
 @return                创建结果
 */
+ (BOOL)createFolder:(NSString *)folderPath iCloudEnable:(BOOL)iCloudEnable;

/*!
 设置文件iCloud属性
 @param enable      iCloud属性
 @param path        路径
 @return            创建结果
 */
+ (BOOL)iCloudEnable:(BOOL)enable atPath:(NSString *)path;

/*!
 获取文件大小
 @param filePath    路径
 @return            文件大小
 */
+ (unsigned long long)getFileSize:(NSString*)filePath;

/*!
 获取剩余空间大小
 @return 剩余空间大小
 */
+ (unsigned long long)getFileSystemFreeSize;

/*!
 获取文件夹大小
 @param folderPath  路径
 @return            文件夹大小
 */
+ (unsigned long long)getFolderSize:(NSString*)folderPath;

/*!
 查找文件
 @param rootPath    查找路径
 @param fileName    文件名
 @return            文件路径
 */
+ (NSString *)findFile:(NSString *)rootPath fileName:(NSString *)fileName;
@end
