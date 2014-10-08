/*!
 @header    NSString+VDUrl
 @abstract  NSString的URLEncode、URLDecode扩展
 */
#import <Foundation/Foundation.h>

/*!
 NSString的URLEncode、URLDecode扩展
 */
@interface NSString (NSString_UrlUtil)

/*!
 url编码
 @return 编码后的string
 */
-(NSString *) urlEncode;

/*!
 url解码
 @return 解码后的string
 */
-(NSString *) urlDecode;

/*!
 查询是否已Encode 
 @discussion 暂不考虑已被encode两次以上的情况
 @return 是否已encode
 */
-(BOOL)checkEncode;

/*!
 安全Encode，避免二次Encode    <br/>
 先检查是否已Encode,再决定是否需要Encode
 @return 返回一次Encode后的url
 */
-(NSString *)urlSafeEncode;

@end
