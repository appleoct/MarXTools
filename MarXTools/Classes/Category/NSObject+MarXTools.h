//
//  NSObject+MarXTools.h
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import <Foundation/Foundation.h>

@interface NSObject (MarXTools)

@end


@interface NSObject (lw_thread)
- (void)lw_runEventInMainThread:(void (^)(void))eventBlock;
@end


@interface NSObject (lw_tag)
@property (nonatomic, assign) NSInteger lw_tag;
@end
