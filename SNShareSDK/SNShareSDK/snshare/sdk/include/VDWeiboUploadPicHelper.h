/*!
 @header VDWeiboUploadPicHelper
 @abstract 为多图分享到微博使用的helper类
 */
#import <Foundation/Foundation.h>
#import <VDShareSynthesizeSingleton.h>
#import "VDShareCommon.h"

@interface VDWeiboUploadPicHelper : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(VDWeiboUploadPicHelper)
/*!
 上传图片到微博<br />
 <font color="#FF0000">这个接口使用的BD合作接口，需要找zhangpeng5@staff.sina.com.cn申请后使用</font><br />
 <font color="#FF0000">https://api.weibo.com/2/statuses/upload_pic.json</font><br />
 
 @param img
 @param accessToken
 @param delegate
 */
- (void) uploadPic:(UIImage *)img accessToken:(NSString *) accessToken key:(NSString *)key delegate:(id<VDWeiboUploadPicDelegate>) delegate;
@end
