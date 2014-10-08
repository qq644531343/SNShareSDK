//
//  BSString.m
//  JiPin
//
//  Created by  on 10-1-5.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSString+VDChinese.h"
#import "RegexKitLite.h"

@implementation NSString (BSSTRING_EXTEND)

+ (NSString *)stringWithUTF8String:(const char *)utf8String defaultValue:(NSString *)defaultValue;
{
	return utf8String?[NSString stringWithUTF8String:utf8String]:defaultValue;
}

+ (BOOL)isChineseCharacter:(unichar)character;
{
    return (character >= 0x4e00 && character <= 0x9fff);
}

- (BOOL)isChineseString;
{
    BOOL isChinese = YES;
    for(NSUInteger i=0; i< [self length];i++){
        unichar a = [self characterAtIndex:i];
        if( [NSString isChineseCharacter:a])
        {
            continue;
        }
        else
        {
            isChinese = NO;
            break;
        }
    }
    return isChinese;
}

- (BOOL)isValidateEmail
{
    return [self isMatchedByRegex:@"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"];
}
@end
