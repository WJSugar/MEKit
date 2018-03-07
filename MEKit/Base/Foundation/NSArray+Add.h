//
//  NSArray+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/13.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSArray (Add)

+ (nullable NSArray *)arrayWithPlistData:(NSData *)plist;
+ (nullable NSArray *)arrayWithPlistString:(NSString *)plist;
- (nullable NSString *)plistData;
- (id)randomObject;
- (nullable id)objectOrNilAtIndex:(NSUInteger)index;
- (nullable NSString *)jsonStringEncoded;
- (nullable NSString *)jsonPrettyStringEncoded;
@end

@interface NSMutableArray(Add)

+ (nullable NSMutableArray *)arrayWithPlistData:(NSData *)plist;
+ (nullable NSMutableArray *)arrayWithPlistString:(NSString *)plist;
- (void)removeFirstObject;
- (void)removeLastObject;
- (nullable id)popFirstObject;
- (nullable id)popLastObject;
- (void)appendObject:(id)anObject;
- (void)prependObject:(id)anObject;
- (void)appendObjects:(NSArray *)objects;
- (void)prependObjects:(NSArray *)objects;
- (void)insertObjects:(NSArray *)objects atIndex:(NSUInteger)index;

- (void)reverse;

- (void)shuffle;


@end









NS_ASSUME_NONNULL_END
