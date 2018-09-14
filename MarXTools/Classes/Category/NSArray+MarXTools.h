//
//  NSArray+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/22.
//

#import <Foundation/Foundation.h>

@interface NSArray (MarXTools)

@end


@interface NSArray (lw_data)


/**
 获取Integer

 @param index 位置index
 @return 返回Integer
 */
- (NSInteger)lw_integerAtIndex:(NSUInteger)index;
- (double)lw_doubleAtIndex:(NSUInteger)index;
- (NSDictionary *)lw_dictionaryAtIndex:(NSUInteger)index;
- (NSArray *)lw_arrayAtIndex:(NSUInteger)index;
- (NSString *)lw_stringAtIndex:(NSUInteger)index;
- (UIImage *)lw_imageAtIndex:(NSUInteger)index;
- (UIImageView *)lw_imageViewAtIndex:(NSUInteger)index;

@end


@interface NSArray (lw_log)

@end
