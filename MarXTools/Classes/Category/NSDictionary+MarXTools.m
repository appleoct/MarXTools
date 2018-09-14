//
//  NSDictionary+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import "NSDictionary+MarXTools.h"

@implementation NSDictionary (MarXTools)

@dynamic lw_jsonString;

- (NSString *)lw_jsonString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

@end


@implementation NSDictionary (lw_data)

- (NSDictionary *)lw_dictFromKey:(NSString *)key
{
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            return (NSDictionary *)value;
        }
    }
    return @{};
}

- (NSArray *)lw_arrayFromKey:(NSString *)key
{
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSArray class]]) {
            return (NSArray *)value;
        }
    }
    return @[];
}

- (NSString *)lw_stringFromKey:(NSString *)key
{
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return (NSString *)value;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value stringValue];
        }
    }
    return @"";
}

- (BOOL)lw_boolFromKey:(NSString *)key
{
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            if ([(NSString *)value integerValue] == 0) {
                return NO;
            }
            return YES;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            if ([(NSNumber *)value integerValue] == 0) {
                return NO;
            }
            return YES;
        }
    }
    return NO;
}

- (NSInteger)lw_integerFromKey:(NSString *)key
{
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return [(NSString *)value integerValue];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value integerValue];
        }
    }
    return 0;
}

- (float)lw_floatFromKey:(NSString *)key
{
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return [(NSString *)value floatValue];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value floatValue];
        }
    }
    return 0;
}

- (double)lw_doubleFromKey:(NSString *)key
{
    if ([self.allKeys containsObject:key]) {
        id value = [self objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            return [(NSString *)value doubleValue];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value doubleValue];
        }
    }
    return 0.00;
}

@end


@implementation NSDictionary (lw_log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"{\n"];
    
    // 遍历字典的所有键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [str appendFormat:@"\t%@ = %@,\n", key, obj];
    }];
    
    [str appendString:@"}"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}

@end
