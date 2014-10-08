#import "NSString+VDUrl.h"

@implementation NSString (NSString_UrlUtil)

-(NSString *) urlEncode
{
    if ([self isKindOfClass:[NSNull class]])
    {
        return @"";
    }

	NSString *result =
    (NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                        (CFStringRef)self,
                                                        NULL,
                                                        CFSTR("!*'();:@&=+$,/?%#[]"),
                                                        kCFStringEncodingUTF8);
#if !__has_feature(objc_arc)
    [result autorelease];
#endif
	return result;

}

-(NSString *) urlDecode
{
    NSString *result =(NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding
                                                        (kCFAllocatorDefault,
                                                         (CFStringRef)self,
                                                         CFSTR(""),
                                                         kCFStringEncodingUTF8);
#if !__has_feature(objc_arc)
    [result autorelease];
#endif
	return result;

}

-(BOOL)checkEncode
{
    if (self.length == 0) {
        return NO;
    }
    
    NSString *newUrl = [self urlDecode];
    if ([newUrl isEqualToString:self]) {
        return NO;
    }else {
        return YES;
    }
}

-(NSString *)urlSafeEncode
{
    if (self.length == 0) {
        return self;
    }
    
    BOOL hasEncode = [self checkEncode];
    if (hasEncode) {
        return self;
    }else {
        return [self urlEncode];
    }
}

@end
