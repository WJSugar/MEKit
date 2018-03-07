//
//  NSNotificationCenter+Add.m
//  MEKit
//
//  Created by jinghua on 16/12/22.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSNotificationCenter+Add.h"
#include <pthread.h>
#import "YYKitMacro.h"

YYSYNTH_DUMMY_CLASS(NSNotificationCenter_Add)

@implementation NSNotificationCenter (Add)

- (void)postNotificationOnMainThread:(NSNotification *)notification {
    if (pthread_main_np()) {
        return [self postNotification:notification];
    }
    [self postNotificationOnMainThread:notification waitUntilDone:NO];
}

- (void)postNotificationOnMainThread:(NSNotification *)notification waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) {
        return [self postNotification:notification];
    }
    [[self class] performSelectorOnMainThread:@selector(_yy_postNotification:) withObject:notification waitUntilDone:wait];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object {
    if (pthread_main_np()) {
        return [self postNotificationName:name object:object userInfo:nil];
    }
    [self postNotificationOnMainThreadWithName:name object:object userInfo:nil waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)useInfo {
    if (pthread_main_np()) {
        return [self postNotificationName:name object:object userInfo:useInfo];
    }
    [self postNotificationOnMainThreadWithName:name object:object userInfo:useInfo waitUntilDone:NO];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)name object:(id)object userInfo:(NSDictionary *)useInfo waitUntilDone:(BOOL)wait {
    if (pthread_main_np()) {
        return [self postNotificationName:name object:object userInfo:useInfo];
    }
    NSMutableDictionary *info = [[NSMutableDictionary allocWithZone:nil] initWithCapacity:3];
    if (name) {
        [info setObject:name forKey:@"name"];
    }
    if (object) {
        [info setObject:object forKey:@"object"];
    }
    if (useInfo) {
        [info setObject:useInfo forKey:@"userInfo"];
    }
    [[self class] performSelectorOnMainThread:@selector(_yy_postNotificationName:) withObject:info waitUntilDone:wait];
}

+ (void)_yy_postNotification:(NSNotification *)notification {
    [[self defaultCenter] postNotification:notification];
}

+ (void)_yy_postNotificationName:(NSDictionary *)info {
    NSString *name = [info objectForKey:@"name"];
    id object = [info objectForKey:@"object"];
    NSDictionary *userInfo = [info objectForKey:@"userInfo"];
    
    [[self defaultCenter] postNotificationName:name object:object userInfo:userInfo];
}












@end
