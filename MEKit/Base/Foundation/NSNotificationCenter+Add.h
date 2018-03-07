//
//  NSNotificationCenter+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/22.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSNotificationCenter (Add)

- (void)postNotificationOnMainThread:(NSNotification *)notification;

- (void)postNotificationOnMainThread:(NSNotification *)notification
                       waitUntilDone:(BOOL)wait;

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object;

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(nullable id)object
                                    userInfo:(nullable NSDictionary *)useInfo;

- (void)postNotificationOnMainThreadWithName:(NSString *)name
                                      object:(id)object
                                    userInfo:(nullable NSDictionary *)useInfo
                               waitUntilDone:(BOOL)wait;










@end
NS_ASSUME_NONNULL_END
