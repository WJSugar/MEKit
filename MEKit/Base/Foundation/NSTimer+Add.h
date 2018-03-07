//
//  NSTimer+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/23.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSTimer (Add)
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *tiemr))block repeats:(BOOL)repeats;

@end
NS_ASSUME_NONNULL_END
