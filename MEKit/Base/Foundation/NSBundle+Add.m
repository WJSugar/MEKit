//
//  NSBundle+Add.m
//  MEKit
//
//  Created by jinghua on 16/12/23.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSBundle+Add.h"
#import "NSString+Add.h"
#import "YYKitMacro.h"

YYSYNTH_DUMMY_CLASS(NSBundle_Add)

@implementation NSBundle (Add)

+ (NSArray *)preferredScales {
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [UIScreen mainScreen].scale;
        if (screenScale <= 1) {
            scales = @[@1, @2, @3];
        } else if (screenScale <= 2) {
            scales = @[@2, @3, @1];
        } else {
            scales = @[@3, @2, @1];
        }
    });
    return scales;
}

+ (NSString *)pathForScaledResource:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)bundlePath {
    if (name.length == 0) {
        return nil;
    }
    if ([name hasSuffix:@"/"]) {
        return [self pathForResource:name ofType:ext inDirectory:bundlePath];
    }
    
    NSString *path = nil;
    NSArray *scales = [self preferredScales];
    for (int i = 0; i < scales.count; i++) {
        CGFloat scale = ((NSNumber *)scales[i]).floatValue;
        NSString *scaledName = ext.length ? [name stringByAppendingNameScale:scale]
        : [name stringByAppendingPathScale:scale];
        path = [self pathForResource:scaledName ofType:ext inDirectory:bundlePath];
        if (path) {
            break;
        }
    }
    return path;
}

- (NSString *)pathForScaledResource:(NSString *)name ofType:(NSString *)ext {
    if (name.length == 0) {
        return nil;
    }
    if ([name hasSuffix:@"/"]) {
        return [self pathForResource:name ofType:ext];
    }
    
    NSString *path = nil;
    NSArray *scales = [NSBundle preferredScales];
    for (int i = 0; i < scales.count; i++) {
        CGFloat scale = ((NSNumber *)scales[i]).floatValue;
        NSString *scaledName = ext.length ? [name stringByAppendingNameScale:scale] :
        [name stringByAppendingPathScale:scale];
        path = [self pathForResource:scaledName ofType:ext];
        if (path) {
            break;
        }
    }
    return path;
}

- (NSString *)pathForScaledResource:(NSString *)name ofType:(NSString *)ext inDirectory:(NSString *)subpath {
    if (name.length == 0) {
        return nil;
    }
    if ([name hasPrefix:@"/"]) {
        return [self pathForResource:name ofType:ext];
    }
    NSString *path = nil;
    NSArray *scales = [NSBundle preferredScales];
    for (int i = 0; i < scales.count; i++) {
        CGFloat scale = ((NSNumber *)scales[i]).floatValue;
        NSString *scaledName = ext.length ? [name stringByAppendingNameScale:scale] :
        [name stringByAppendingPathScale:scale];
        path = [self pathForResource:scaledName ofType:ext inDirectory:subpath];
        if (path) {
            break;
        }
    }
    return path;
}
@end
