//
//  NSThread+Add.m
//  MEKit
//
//  Created by jinghua on 16/12/24.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSThread+Add.h"
#import <CoreFoundation/CoreFoundation.h>

@interface NSThread_Add : NSObject @end
@implementation NSThread_Add @end

#if __has_feature(objc_arc)
#error This file must be compiled without ARC. Specify the -fno-objc-arc flag to this file
#endif

static NSString *const NSThreadAutoleasePoolKey = @"NSThreadAutoleasePoolKey";
static NSString *const NSThreadAutoleasePoolStackKey = @"NSThreadAutoleasePoolStackKey";

static const void *PoolStackRetainCallBack(CFAllocatorRef allocator, const void *value) {
    return value;
}

static void PoolStackReleaseCallBack(CFAllocatorRef allocator, const void *value) {
    CFRelease((CFTypeRef)value);
}

static inline void AutoreleasePoolPush() {
    NSMutableDictionary *dic = [NSThread currentThread].threadDictionary;
    NSMutableArray *poolStack = dic[NSThreadAutoleasePoolStackKey];
    if (!poolStack) {
        CFArrayCallBacks callbacks = {0};
        callbacks.retain = PoolStackRetainCallBack;
        callbacks.release = PoolStackReleaseCallBack;
        poolStack = (id)CFArrayCreateMutable(CFAllocatorGetDefault(), 0, &callbacks);
        dic[NSThreadAutoleasePoolStackKey] = poolStack;
        CFRelease(poolStack);
    }
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [poolStack addObject:pool]; //push
}

static inline void AutoreleasePoolPop() {
    NSMutableDictionary *dic = [NSThread currentThread].threadDictionary;
    NSMutableArray *poolStack = dic[NSThreadAutoleasePoolStackKey];
    [poolStack removeLastObject]; //pop
}

static void RunLoopAutoreleasePoolObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry: {
            AutoreleasePoolPush();
        } break;
        case kCFRunLoopBeforeWaiting: {
            AutoreleasePoolPop();
            AutoreleasePoolPush();
        } break;
        case kCFRunLoopExit: {
            AutoreleasePoolPop();
        } break;
        default:
            break;
    }
}

static void RunloopAutoreleasePoolSetup() {
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    CFRunLoopObserverRef pushObserver;
    pushObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopEntry,
                                           true,
                                           -0x7FFFFFFF,
                                           RunLoopAutoreleasePoolObserverCallBack, NULL);
    CFRunLoopAddObserver(runloop, pushObserver, kCFRunLoopCommonModes);
    CFRelease(pushObserver);
    
    CFRunLoopObserverRef popObserver;
    popObserver = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting | kCFRunLoopExit,
                                           true,
                                           0x7FFFFFFF,
                                           RunLoopAutoreleasePoolObserverCallBack, NULL);
    CFRunLoopAddObserver(runloop, popObserver, kCFRunLoopCommonModes);
    CFRelease(popObserver);
}

@implementation NSThread (Add)

+ (void)addAutoreleasePoolToCurrentRunloop {
    if ([NSThread isMainThread]) {
        return;
    }
    NSThread *thread = [self currentThread];
    if (!thread) {
        return;
    }
    if (thread.threadDictionary[NSThreadAutoleasePoolKey]) {
        return;
    }
    RunloopAutoreleasePoolSetup();
    thread.threadDictionary[NSThreadAutoleasePoolKey] = NSThreadAutoleasePoolKey;
}

@end
