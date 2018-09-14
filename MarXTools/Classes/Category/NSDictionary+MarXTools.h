//
//  NSDictionary+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MarXTools)
@property (nonatomic, copy) NSString *lw_jsonString;
@end


@interface NSDictionary (lw_data)
- (NSDictionary *)lw_dictFromKey:(NSString *)key;
- (NSArray *)lw_arrayFromKey:(NSString *)key;
- (NSString *)lw_stringFromKey:(NSString *)key;
- (BOOL)lw_boolFromKey:(NSString *)key;
- (NSInteger)lw_integerFromKey:(NSString *)key;
- (float)lw_floatFromKey:(NSString *)key;
- (double)lw_doubleFromKey:(NSString *)key;
@end


@interface NSDictionary (lw_log)

@end
