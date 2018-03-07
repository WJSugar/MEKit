//
//  NSTimer+Add.m
//  MEKit
//
//  Created by jinghua on 16/12/23.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSTimer+Add.h"

@implementation NSTimer (Add)

//这个方法是用来执行一个block，参数数一个timer，如果这个timer有一个userInfo的话就执行这个block
+ (void)_yy_ExecBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *))block repeats:(BOOL)repeats {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(_yy_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *))block repeats:(BOOL)repeats {
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(_yy_ExecBlock:) userInfo:[block copy] repeats:repeats];
}

@end
