//
//  NSString+Add.h
//  MEKit
//
//  Created by jinghua on 16/11/3.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (Add)

- (nullable NSString *)md2String;
- (nullable NSString *)md4String;
- (nullable NSString *)md5String;

- (nullable NSString *)sha1String;
- (nullable NSString *)sha224String;
- (nullable NSString *)sha256String;
- (nullable NSString *)sha384String;
- (nullable NSString *)sha512String;

- (nullable NSString *)hmacMD5StringWithKey:(NSString *)key;
- (nullable NSString *)hmacSHA1StringWithKey:(NSString *)key;
- (nullable NSString *)hmacSHA224StringWithKey:(NSString *)key;
- (nullable NSString *)hmacSHA256StringWithKey:(NSString *)key;
- (nullable NSString *)hmacSHA384StringWithKey:(NSString *)key;
- (nullable NSString *)hmacSHA512StringWithKey:(NSString *)key;

- (nullable NSString *)crc32String;

- (nullable NSString *)base64EncodedString;
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;

- (NSString *)stringByURLEncode;
- (NSString *)stringByURLDecode;
- (NSString *)stringByEscapingHTML;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
- (CGFloat)widthForFont:(UIFont *)font;
- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options;
- (void)enumerateRegexMatche:(NSString *)regex
                     options:(NSRegularExpressionOptions)options
                  usingBlock:(void(^)(NSString *match, NSRange matchRange, BOOL *stop))block;
- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement;

@property (readonly) char charValue;
@property (readonly) unsigned char unsignedCharValue;
@property (readonly) short shortValue;
@property (readonly) unsigned  short unsignedShortValue;
@property (readonly) unsigned int unsignedIntValue;
@property (readonly) long longValue;
@property (readonly) unsigned long unsignedLongValue;
@property (readonly) unsigned long long unsignedLongLongValue;
@property (readonly) NSUInteger unsigendIntegerValue;

+ (NSString *)stringWithUUID;
+ (nullable NSString *)stringWithUTF32Char:(UTF32Char)char32;
+ (nullable NSString *)stringWhitUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length;
- (void)enumerateUTF32CharInRange:(NSRange)range usingBlock:(void(^)(UTF32Char char32, NSRange range, BOOL *stop))block;

- (NSString *)stringByTrim;
- (NSString *)stringByAppendingNameScale:(CGFloat)scale;
- (NSString *)stringByAppendingPathScale:(CGFloat)scale;
- (CGFloat)pathScale;

- (BOOL)isNotBlank;
- (BOOL)containsString:(NSString *)string;
- (BOOL)containsCharacterSet:(NSCharacterSet *)set;

- (nullable NSNumber *)numberValue;
- (nullable NSData *)dataValue;
- (NSRange)rangeOfAll;
- (nullable id)jsonValueDecoded;
+ (nullable NSString *)stringNamed:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
