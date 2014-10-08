#import "VDShareFileHandle.h"

@interface VDShareFileHandle ()

- (id) initWithNSFileHandle:(NSFileHandle*)fileHandle;

@end


@implementation VDShareFileHandle

+ (NSString *)getAppTempPath
{
    return NSTemporaryDirectory();
}

+ (NSString *)getAppDocumentPath
{
    static NSString* sAPPDocumentPATH = nil;
	if (sAPPDocumentPATH == nil)
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		if ([paths count] > 0)
		{
			sAPPDocumentPATH = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
		}
	}
	return sAPPDocumentPATH;
}

+ (NSString*) getAppCachePath
{
	static NSString* sAPPCACHEPATH = nil;
	if (sAPPCACHEPATH == nil)
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
		if ([paths count] > 0)
		{
			sAPPCACHEPATH = [[NSString alloc] initWithString:[paths objectAtIndex:0]];
		}
	}
	return sAPPCACHEPATH;
}

+ (id) fileHandleForReadAtPath:(NSString*)path
{
	if (path == nil) return nil;
	NSFileHandle* fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
	if (fileHandle == nil) return nil;
	
	return [[[VDShareFileHandle alloc] initWithNSFileHandle:fileHandle] autorelease];
}

+ (id) fileHandleForWriteAtPath:(NSString*)path
{
	if (path == nil) return nil;
	NSFileManager* tFileManager = [NSFileManager defaultManager];
	if (![tFileManager fileExistsAtPath:path])
	{
		[tFileManager createFileAtPath:path contents:nil attributes:nil];
	}
	
	NSFileHandle* fileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
	if (fileHandle == nil) return nil;
	
	return [[[VDShareFileHandle alloc] initWithNSFileHandle:fileHandle] autorelease];
}

- (id) initWithNSFileHandle:(NSFileHandle*)fileHandle;
{
    if ((self = [super init])) 
	{
		_fileHandle = [fileHandle retain];
    }
    return self;
}

- (void) appendData:(NSData*)data
{
	NSAssert(data != nil, @"data不可以为nil");
	[_fileHandle seekToEndOfFile];
	int dataLen = [data length];
	NSData* tData = [NSData dataWithBytes:&dataLen length:4];
	[_fileHandle writeData:tData];
	[_fileHandle writeData:data];
	[_fileHandle synchronizeFile];
}

- (void) writeData:(NSData*)data
{
	NSAssert(data != nil, @"data不可以为nil");
	int dataLen = [data length];
	NSData* tData = [NSData dataWithBytes:&dataLen length:4];
	[_fileHandle writeData:tData];
	[_fileHandle writeData:data];
	[_fileHandle synchronizeFile];
}

- (NSData*) readData
{
	NSData* data = [_fileHandle readDataOfLength:4];
	if (data == nil) return nil;
	
	int dataLen = 0;
	[data getBytes:&dataLen length:4];
	
	if (dataLen <= 0) return nil;
	
	return [_fileHandle readDataOfLength:dataLen];
}

+ (BOOL) removeFileAtPath:(NSString*)path
{
	if (path == nil) return YES;
	
	NSFileManager* tFileManager = [NSFileManager defaultManager];
	if ([tFileManager fileExistsAtPath:path])
	{
		NSError *errorInfo;
		[tFileManager removeItemAtPath:path error:&errorInfo];
	}
	
	return YES;
}

+ (BOOL) containFileAtPath:(NSString*)path
{
	if (path == nil) return NO;	
	return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL) copyFile:(NSString*)srcFilePath to:(NSString*)destFilePath
{
	if (srcFilePath == nil) return NO;
	if (destFilePath == nil) return NO;
	return [[NSFileManager defaultManager] copyItemAtPath:srcFilePath toPath:destFilePath error:nil];
}

+ (BOOL) rename:(NSString*)srcFilePath to:(NSString*)destFilePath
{
	if (srcFilePath == nil) return NO;
	if (destFilePath == nil) return NO;
	return [[NSFileManager defaultManager] moveItemAtPath:srcFilePath toPath:destFilePath error:nil];
}

+ (TFileSize) getFileSize:(NSString*)path
{
	if (path == nil) return 0;
	
	NSFileManager* tFileManager = [NSFileManager defaultManager];
	NSError *errorInfo = nil;
	NSDictionary* attributes = [tFileManager attributesOfItemAtPath:path error:&errorInfo];
	
	TFileSize fileLength = 0;
	if (attributes != nil)
	{
		fileLength = [attributes fileSize];
	}
	return fileLength;
}

+ (void) removeFilesAtDirPath:(NSString*)path ext:(NSString*)ext
{
	if (path == nil) return;
	NSFileManager* tFileManager = [NSFileManager defaultManager];
	NSError *errorInfo = nil;
	
	NSArray* files = [tFileManager contentsOfDirectoryAtPath:path error:&errorInfo];
	if (errorInfo == nil)
	{
		for (NSString* filePath in files)
		{
			if ([filePath hasSuffix:ext])
			{
				[tFileManager removeItemAtPath:filePath error:&errorInfo];
			}
		}
	}
}

+ (NSArray*) getContentsbyDir:(NSString*)path
{
	if (path == nil) return nil;
	
	NSFileManager* tFileManager = [NSFileManager defaultManager];
	NSError *errorInfo = nil;
	return [tFileManager contentsOfDirectoryAtPath:path error:&errorInfo];
}

+ (NSDate*) getFileModificationDate:(NSString*)path
{
	if (path == nil) return nil;
	
	NSFileManager* tFileManager = [NSFileManager defaultManager];
	NSError *errorInfo = nil;
	NSDictionary* attributes = [tFileManager attributesOfItemAtPath:path error:&errorInfo];
	
	NSDate* date = nil;;
	if (attributes != nil)
	{
		date = [attributes fileModificationDate];
	}
	return date;
}

+ (BOOL) writeData:(NSData*)data toPath:(NSString*)path
{
	if (path == nil) return NO;
	
	VDShareFileHandle* tFileHandle = [VDShareFileHandle fileHandleForWriteAtPath:path];
	if (tFileHandle == nil) return NO;

	[tFileHandle writeData:data];
	return YES;
}

+ (NSData*) readDataFromPath:(NSString*)path
{
	NSData* data = nil;
	if (path != nil)
	{
		VDShareFileHandle* tFileHandle = [VDShareFileHandle fileHandleForReadAtPath:path];
		if (tFileHandle != nil)
		{
			data = [tFileHandle readData];
		}
	}
	return data;
}

+ (BOOL) createPath:(NSString*)path
{
	if (path == nil) return NO;
	
	return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
}

+ (BOOL)createDirectoryForFilePath:(NSString *)filePath
{
    if(nil == filePath)
    {
        return NO;
    }
    NSString * dirPath = [filePath stringByDeletingLastPathComponent];
    BOOL isDir;
    if([[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDir])
    {
        return isDir;
    }

    return [[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
}

- (void)dealloc
{
	[_fileHandle release];
    [super dealloc];
}
@end
