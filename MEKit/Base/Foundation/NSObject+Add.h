//
//  NSObject+Add.h
//  MEKit
//
//  Created by jinghua on 16/11/10.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSObject (Add)

- (nullable id)performSelectorWithArgs:(SEL)sel, ...;
- (void)performSelectorWithArgs:(SEL)sel afterDelay:(NSTimeInterval)delay, ...;
- (nullable id)performSelectorWithArgsOnMainThread:(SEL)sel watiUntilDone:(BOOL)wait, ...;
- (nullable id)performSelectorWithArgs:(SEL)sel onThread:(NSThread *)thread waitUntilDone:(BOOL) wiat, ...;
- (void)performSelectorWithArgsInBackground:(SEL)sel, ...;
- (void)performSelector:(SEL)sel afterDelay:(NSTimeInterval)delay;

+ (BOOL)swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel;
+ (BOOL)swizzleClassMethod:(SEL)originalSel with:(SEL)newSel;

- (void)setAssociateValue:(nullable id)value withKey:(void *)key;
- (void)setAssociateWeakValue:(nullable id)value withKey:(void*)key;

- (nullable id)getAssociatedValueForKey:(void *)key;
- (void)removeAssociatedValues;

+ (NSString *)className;
- (NSString *)className;
- (nullable id)deepCopy;
- (nullable id)deepCopyWithArchiver:(Class)archievr unarchiver:(Class)unarchiver;
@end
NS_ASSUME_NONNULL_END
