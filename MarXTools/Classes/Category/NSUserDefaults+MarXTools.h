//
//  NSUserDefaults+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (MarXTools)

+ (void) lw_setStringValue:(NSString*) value forKey:(NSString*) key;
+ (NSString*) lw_getStringForKey:(NSString*) key;

+ (id) lw_getValueForKey:(NSString*) key;
+ (void) lw_setValue:(id) value forKey:(NSString*) key;

@end
