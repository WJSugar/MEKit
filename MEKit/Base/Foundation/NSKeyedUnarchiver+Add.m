//
//  NSKeyedUnarchiver+Add.m
//  MEKit
//
//  Created by jinghua on 16/12/22.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSKeyedUnarchiver+Add.h"

@implementation NSKeyedUnarchiver (Add)
+ (id)unarchiverObjectWithData:(NSData *)data exception:(__autoreleasing NSException **)exception {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    } @catch (NSException *e) {
        if (exception) {
            *exception = e;
        }
    } @finally {
    }
    return object;
}

+ (id)unarchiverObejctWithFile:(NSString *)path exception:(__autoreleasing NSException **)exception {
    id object = nil;
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    } @catch (NSException *e) {
        if (exception) {
            *exception = e;
        }
    } @finally {
        
    }
    return object;
}

@end
