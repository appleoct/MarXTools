//
//  NSObject+MarXTools.m
//  MarXTools
//
//  Created by CodeRiding on 2018/6/21.
//

#import "NSObject+MarXTools.h"
#import <objc/runtime.h>

@implementation NSObject (MarXTools)

@end


#pragma mark - 
@implementation NSObject (lw_thread)
- (void)lw_runEventInMainThread:(void (^)(void))eventBlock
{
    NSThread *currentThread =  [NSThread currentThread];
    if ([currentThread isMainThread]){
        eventBlock();
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        eventBlock();
    });
}
@end


#pragma mark - 
static const int lw_tagKey = 0;
@implementation NSObject (lw_tag)
- (NSInteger)lw_tag
{
    return [objc_getAssociatedObject(self, &lw_tagKey) integerValue];
}

- (void)setLw_tag:(NSInteger)lw_tag
{
    objc_setAssociatedObject(self, &lw_tagKey, @(lw_tag), OBJC_ASSOCIATION_ASSIGN);
}
@end
