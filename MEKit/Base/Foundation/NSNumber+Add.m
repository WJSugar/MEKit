//
//  NSNumber+Add.m
//  MEKit
//
//  Created by jinghua on 16/12/4.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSNumber+Add.h"
#import "NSString+Add.h"


@implementation NSNumber (Add)
+ (NSNumber *)numberWithString:(NSString *)string {
    //去除空格并且转换为小写
    NSString *str = [[string stringByTrim] lowercaseString];
    if (!str || !str.length) {
        return nil;
    }
    
    static NSDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dic = @{ @"true"  : @(YES),
                 @"yes"   : @(YES),
                 @"false" : @(NO),
                 @"no"    : @(NO),
                 @"nil"   : [NSNull null],
                 @"null"  : [NSNull null],
                 @"<null>": [NSNull null]
                };
    });
    
    id num = dic[str];
    if (num) {
        if (num == [NSNull null]) {
            return nil;
        }
        return num;
    }
    
    //hex number
    int sign = 0;
    if ([str hasPrefix:@"0x"]) {
        sign = 1;
    } else if ([str hasPrefix:@"-0x"]) {
        sign = -1;
    }
    if (sign != 0) {
        NSScanner *scan = [NSScanner scannerWithString:str];
        unsigned num = -1;
        BOOL suc = [scan scanHexInt:&num];
        if (suc) {
            return [NSNumber numberWithLong:((long)num *sign)];
        } else {
            return nil;
        }
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [formatter numberFromString:string];
}
@end

