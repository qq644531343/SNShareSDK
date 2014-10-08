
#import "NSDictionary+VDExtending.h"


@implementation NSDictionary (DictionaryExtending)

- (BOOL)hasValueForKey:(NSString *)key
{
    
    BOOL hasValue = FALSE;
    if (key)
    {
        if ([self valueForKey:key])
        {
            hasValue = TRUE;
        }
    }
    
    return hasValue;
}


- (int)intValueForKey:(NSString *)key
{
    int intValue = 0;
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object respondsToSelector:@selector(intValue)])
        {
            intValue = [object intValue];
        }
    }
    return intValue;
}

- (BOOL)boolValueForKey:(NSString *)key
{
    BOOL boolValue = FALSE;
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object respondsToSelector:@selector(boolValue)])
        {
            boolValue = [object boolValue];
        }
    }
    return boolValue;
}

- (double)doubleValueForKey:(NSString *)key
{
    double doubleValue = 0.0;
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object respondsToSelector:@selector(doubleValue)])
        {
            doubleValue = [object doubleValue];
        }
    }
    return doubleValue;
}


- (float)floatValueForKey:(NSString *)key
{
    float floatValue = 0.0;
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object respondsToSelector:@selector(floatValue)])
        {
            floatValue = [object floatValue];
        }
    }
    return floatValue;
}

- (long)longValueForKey:(NSString *)key
{
    long longValue = 0;
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object respondsToSelector:@selector(longValue)])
        {
            longValue = [object longValue];
        }
    }
    return longValue;
}

- (long long)longLongValueForKey:(NSString *)key
{
    long long longLongValue = 0;
    if (key)
    {
        id object = nil; 
        
        if ([self respondsToSelector:@selector(valueForKey:)]) {
            
            object = [self valueForKey:key];
        }
        
        if (object && [object respondsToSelector:@selector(longLongValue)])
        {
            longLongValue = [object longLongValue];
        }
    }
    return longLongValue;
}

- (CGRect)rectValueForKey:(NSString *)key
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object isKindOfClass:[NSDictionary class]])
        {
            bool result = false;
            result = CGRectMakeWithDictionaryRepresentation((CFDictionaryRef)object, &rect);
            if (!result)
            {
                rect = CGRectMake(0.0f, 0.0f, 0.0f, 0.0f);
            }
        }
    }
    return rect;
}

- (CGPoint)pointValueForKey:(NSString*)key
{
    CGPoint point = CGPointMake(0.0f, 0.0f);
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object isKindOfClass:[NSDictionary class]])
        {
            bool result = false;
            result = CGPointMakeWithDictionaryRepresentation((CFDictionaryRef)object, &point);
            if (!result)
            {
                point = CGPointMake(0.0f, 0.0f);
            }
        }
    }
    return point;
}

- (CGSize)sizeValueForKey:(NSString*)key
{
    CGSize si = CGSizeMake(0.0f, 0.0f);
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object isKindOfClass:[NSDictionary class]])
        {
            bool result = false;
            result = CGSizeMakeWithDictionaryRepresentation((CFDictionaryRef)object, &si);
            if (!result)
            {
                si = CGSizeMake(0.0f, 0.0f);
            }
        }
    }
    return si;
}

- (const char *)cStringForKey:(NSString *)key
{
    const char *cString = NULL;
    if (key)
    {
        id object = [self valueForKey:key];
        if (object && [object respondsToSelector:@selector(UTF8String)])
        {
            cString = [object UTF8String];
        }
    }
    
    return cString;
    
}

- (SEL)selectorForKey:(NSString *)key
{
    SEL selector = NULL;
    const char *name = [self cStringForKey:key];
    if (name) 
    {
        selector = sel_registerName(name);
    }
    return selector;
}


@end
