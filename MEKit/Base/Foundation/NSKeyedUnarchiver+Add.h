//
//  NSKeyedUnarchiver+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/22.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSKeyedUnarchiver (Add)
+ (nullable id)unarchiverObjectWithData:(NSData *)data
                              exception:(NSException *_Nullable *_Nullable)exception;
+ (nullable id)unarchiverObejctWithFile:(NSString *)path
                              exception:(NSException *_Nullable *_Nullable)exception;
@end
NS_ASSUME_NONNULL_END
