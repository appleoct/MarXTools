//
//  NSArray+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import "NSArray+MarXTools.h"

@implementation NSArray (MarXTools)

@end


@implementation NSArray (lw_data)

- (NSInteger)lw_integerAtIndex:(NSUInteger)index
{
    if ([self count] > index) {
        id value = [self objectAtIndex:index];
        if ([value isKindOfClass:[NSString class]]) {
            return [(NSString *)value integerValue];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value integerValue];
        }
    }
    return 0;
}

- (double)lw_doubleAtIndex:(NSUInteger)index
{
    if ([self count] > index) {
        id value = [self objectAtIndex:index];
        if ([value isKindOfClass:[NSString class]]) {
            return [(NSString *)value doubleValue];
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value doubleValue];
        }
    }
    return 0.00;
}

- (NSDictionary *)lw_dictionaryAtIndex:(NSUInteger)index
{
    if ([self count] > index) {
        id value = [self objectAtIndex:index];
        if ([value isKindOfClass:[NSDictionary class]]) {
            return (NSDictionary *)value;
        }
    }
    return @{};
}

- (NSArray *)lw_arrayAtIndex:(NSUInteger)index
{
    if ([self count] > index) {
        id value = [self objectAtIndex:index];
        if ([value isKindOfClass:[NSArray class]]) {
            return (NSArray *)value;
        }
    }
    return @[];
}

- (NSString *)lw_stringAtIndex:(NSUInteger)index
{
    if ([self count] > index) {
        id value = [self objectAtIndex:index];
        if ([value isKindOfClass:[NSString class]]) {
            return (NSString *)value;
        }
        if ([value isKindOfClass:[NSNumber class]]) {
            return [(NSNumber *)value stringValue];
        }
    }
    return @"";
}

- (UIImage *)lw_imageAtIndex:(NSUInteger)index
{
    if ([self count] > index){
        id value = [self objectAtIndex:index];
        if ([value isKindOfClass:[UIImage class]]){
            return (UIImage *)value;
        }
    }
    
    return nil;
}

- (UIImageView *)lw_imageViewAtIndex:(NSUInteger)index
{
    if ([self count] > index){
        id value = [self objectAtIndex:index];
        if ([value isKindOfClass:[UIImageView class]]){
            return (UIImageView *)value;
        }
    }
    
    return [UIImageView new];
}

@end


@implementation NSArray (lw_log)
- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str = [NSMutableString string];
    
    [str appendString:@"[\n"];
    
    // 遍历数组的所有元素
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [str appendFormat:@"%@,\n", obj];
    }];
    
    [str appendString:@"]"];
    
    // 查出最后一个,的范围
    NSRange range = [str rangeOfString:@"," options:NSBackwardsSearch];
    if (range.length) {
        // 删掉最后一个,
        [str deleteCharactersInRange:range];
    }
    
    return str;
}
@end
