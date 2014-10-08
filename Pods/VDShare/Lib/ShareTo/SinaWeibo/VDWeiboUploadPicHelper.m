#import "VDWeiboUploadPicHelper.h"
#import "JSONKit.h"

@implementation VDWeiboUploadPicHelper
SYNTHESIZE_SINGLETON_FOR_CLASS(VDWeiboUploadPicHelper)

- (id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)uploadPic:(UIImage *)img accessToken:(NSString *)accessToken key:(NSString *)key delegate:(id<VDWeiboUploadPicDelegate>)delegate
{
    if(!img || !delegate)
    {
        return;
    }
    NSString *url = @"https://api.weibo.com/2/statuses/upload_pic.json";
//    NSString *url = @"http://192.168.2.1/test/index.php";
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"7d33a816d302b6";
    //构造http header
    [request setValue:[NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary] forHTTPHeaderField:@"Content-Type"];
    //构造http body
    NSMutableData *body = [NSMutableData dataWithCapacity:1];
    //pic
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"pic\"; filename=\"%@.jpg\"\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:UIImageJPEGRepresentation(img,1.f)];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //accesstoken
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"access_token\"\r\n\r\n%@", accessToken] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    //end
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    //挂上去
    [request setHTTPBody:body];
    
    NSString *postLen = [NSString stringWithFormat:@"%d",[body length]];
    [request setValue:postLen forHTTPHeaderField:@"Content-Length"];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[[NSOperationQueue alloc] init] autorelease] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                if([delegate respondsToSelector:@selector(onUploadRequest:picID:key:)])
                {
                    [delegate onUploadRequest:NO picID:nil key:key];
                }
                if([delegate respondsToSelector:@selector(onUploadError:desc:)])
                {
                    [delegate onUploadError:-1 desc:@"connectionError is not nil"];
                }
            });
            return;
        }
        NSString *picID = @"";
        
        NSString *responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if(responseStr)
        {
            NSDictionary *dict = [responseStr objectFromJSONString];
            if([dict objectForKey:@"error"])
            {
                if([delegate respondsToSelector:@selector(onUploadRequest:picID:key:)])
                {
                    [delegate onUploadRequest:NO picID:nil key:key];
                }
                if([delegate respondsToSelector:@selector(onUploadError:desc:)])
                {
                    [delegate onUploadError:[[dict objectForKey:@"error_code"] intValue] desc:[dict objectForKey:@"error"]];
                }
                return;
            }
            picID = [dict objectForKey:@"pic_id"];
        }
        
        if([delegate respondsToSelector:@selector(onUploadRequest:picID:key:)])
        {
            [delegate onUploadRequest:YES picID:picID key:key];
        }
    }];
}

@end
