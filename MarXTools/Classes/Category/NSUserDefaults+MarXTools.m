//
//  NSUserDefaults+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import "NSUserDefaults+MarXTools.h"

@implementation NSUserDefaults (MarXTools)

+ (id) lw_getValueForKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
}

+ (void) lw_setValue:(id) value forKey:(NSString*) key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




+ (NSString*) lw_getStringForKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (void) lw_setStringValue:(NSString*) value forKey:(NSString*) key
{
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}




+ (BOOL) lw_getBoolForKey:(NSString*) key
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (void) lw_setBool:(BOOL) value forKey:(NSString*) key
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}



+ (NSInteger)lw_getIntegerForKey:(NSString *)key
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
}

+ (void)lw_setInteger:(NSInteger)value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
