
#import "NSMutableDictionary+VDExtending.h"

@implementation NSMutableDictionary (DictionaryExtending)

- (void)setIntValue:(int)intValue forKey:(NSString *)key
{
    if (key)
    {
        [self setValue:[NSNumber numberWithInt:intValue] forKey:key];
    }
}

- (void)setBoolValue:(BOOL)boolValue forKey:(NSString *)key
{
    if (key)
    {
        [self setValue:[NSNumber numberWithBool:boolValue] forKey:key];
    }
}

- (void)setDoubleValue:(double)doubleValue forKey:(NSString *)key;
{
    if (key)
    {
        [self setValue:[NSNumber numberWithDouble:doubleValue] forKey:key];
    }
}

- (void)setFloatValue:(float)floatValue forKey:(NSString *)key;
{
    if (key)
    {
        [self setValue:[NSNumber numberWithFloat:floatValue] forKey:key];
    }
}

- (void)setLongValue:(long)longValue forKey:(NSString *)key
{
    if (key)
    {
        [self setValue:[NSNumber numberWithLong:longValue] forKey:key];
    }
}

- (void)setLongLongValue:(long long)longLongValue forKey:(NSString *)key
{
    if (key)
    {
        [self setValue:[NSNumber numberWithLongLong:longLongValue] forKey:key];
    }
}

- (void)setRect:(CGRect)rect forKey:(NSString *)key
{
    if (key)
    {
        CFDictionaryRef dictionaryRef = CGRectCreateDictionaryRepresentation(rect);
        if (dictionaryRef)
        {
            [self setValue:(NSDictionary *)dictionaryRef forKey:key];
            CFRelease(dictionaryRef);
        }
    }
}

- (void)setPoint:(CGPoint)point forKey:(NSString*)key
{
    if (key)
    {
        CFDictionaryRef dictionaryRef = CGPointCreateDictionaryRepresentation(point);
        if (dictionaryRef)
        {
            [self setValue:(NSDictionary*)dictionaryRef forKey:key];
            CFRelease(dictionaryRef);
        }
    }
}

- (void)setSize:(CGSize)si forKey:(NSString *)key
{
    if (key)
    {
        CFDictionaryRef dictionaryRef = CGSizeCreateDictionaryRepresentation(si);
        if (dictionaryRef)
        {
            [self setValue:(NSDictionary*)dictionaryRef forKey:key];
            CFRelease(dictionaryRef);
        }
    }
}

- (void)setCString:(const char *)cString forKey:(NSString *)key
{
    if (key)
    {
        if (cString)
        {
            [self setValue:[NSString stringWithUTF8String:cString] forKey:key];
        }
        else
        {
            [self setValue:nil forKey:key];
        }
    }
}

- (void)setSelector:(SEL)selector forKey:(NSString *)key
{
    if (key)
    {
        if (selector)
        {
            [self setCString:sel_getName(selector) forKey:key];
        }
    }
    
}


@end
