//
//  NSString+Add.m
//  MEKit
//
//  Created by jinghua on 16/11/3.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSString+Add.h"
#import "NSData+Add.h"
#import "NSString+Add.h"
#import "YYKitMacro.h"
#import "NSNumber+Add.h"


@implementation NSString (Add)
- (NSString *)md2String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md2String];
}

- (NSString *)md4String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md4String];
}

- (NSString *)md5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] md5String];
}

- (NSString *)sha1String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha1String];
}

- (NSString *)sha224String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha224String];
}

- (NSString *)sha256String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha256String];
}

- (NSString *)sha512String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] sha512String];
}

- (NSString *)crc32String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] crc32String];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacMD5StringWithKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA1StringWithKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA256StringWithKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] hmacSHA512StringWithKey:key];
}

- (NSString *)base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}

+ (NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString {
    NSData *data = [NSData dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)stringByURLEncode {
    //可以使用这个API，对允许的字符进行添加%编码
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        //界定符
        static NSString * const kAFCharacterGeneralDelimitersToEncode = @":#[]@";
        static NSString * const kAFCharacterSubDelimitersToEncode = @"!$&'()*+,;=";
        //获取到URL允许的字符集
        NSMutableCharacterSet *allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        //将界定符从中移除
        [allowedCharacterSet removeCharactersInString:[kAFCharacterGeneralDelimitersToEncode stringByAppendingString:kAFCharacterSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        //实现遍历整个字符串的操作
        while (index < self.length) {
            //使得每次遍历的范围不超过50个字符
            NSUInteger length = MIN(self.length - index, batchSize);
            //设置相应的范围
            NSRange range = NSMakeRange(index, length);
            //取得整个范围内在本字符的范围  ？？？？？ 获取到真正的字符的range去除emoji😈等字符
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            //根据所选范围截取字符串
            NSString *substring = [self substringWithRange:range];
            //截取出的字符串进行%编码
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            //拼接到可变字符串上
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declararions"
        //直接使用CoreFoundation框架的进行编码
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        //字符串转化为CFString 输入需要转换的字符串和编码格式UTF-8
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByURLDecode {
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                    NULL,
                                                                    (__bridge CFStringRef)decoded,
                                                                    CFSTR(""),
                                                                    en);
        return decoded;
#pragma clang diagnostic pop
    }
}

- (NSString *)stringByEscapingHTML {
    NSUInteger len = self.length;
    if (!len) {
        return self;
    }
    unichar *buf = malloc(sizeof(unichar) *len);
    if (!buf) {
        return self;
    }
    [self getCharacters:buf range:NSMakeRange(0, len)];
    
    NSMutableString *result = [NSMutableString string];
    for (int i = 0; i < len; i++) {
        //取出字符  ascill码
        unichar c = buf[i];
        NSString *esc = nil;
        switch (c) {
            case 34: esc = @"&quot";  break;
            case 38: esc = @"&amp;";  break;
            case 39: esc = @"&apos;"; break;
            case 60: esc = @"&lt;";   break;
            case 62: esc = @"&gt;";   break;
            default: break;
        }
        if (esc) {
            [result appendString:esc];
        } else {
            //将字符拼接到可变字符串上
            CFStringAppendCharacters((CFMutableStringRef)result, &c, 1);
        }
    }
    free(buf);
    return result;
}

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) {
        font = [UIFont systemFontOfSize:12];
    }
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin |
                                      NSStringDrawingUsesFontLeading
                                      attributes:attr
                                         context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)widthForFont:(UIFont *)font {
    CGSize size = [self sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

- (BOOL)matchesRegex:(NSString *)regex options:(NSRegularExpressionOptions)options {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex
                                                                             options:options
                                                                               error:NULL];
    //Pattern 可能为空，因此需要判断
    if (!pattern) {
        return NO;
    }
    //匹配的个数
    return ([pattern numberOfMatchesInString:self options:0 range:NSMakeRange(0, self.length)] > 0);
}

- (void)enumerateRegexMatche:(NSString *)regex
                     options:(NSRegularExpressionOptions)options
                  usingBlock:(void(^)(NSString *match, NSRange matchRange, BOOL *stop))block {
    if (regex.length == 0 || !block) {
        return;
    }
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) {
        return;
    }
    [pattern enumerateMatchesInString:self options:kNilOptions range:NSMakeRange(0, self.length) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        block([self substringWithRange:result.range], result.range, stop);
    }];
}

- (NSString *)stringByReplacingRegex:(NSString *)regex
                             options:(NSRegularExpressionOptions)options
                          withString:(NSString *)replacement {
    NSRegularExpression *pattern = [NSRegularExpression regularExpressionWithPattern:regex options:options error:nil];
    if (!pattern) {
        return self;
    }
    return [pattern stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:regex];
}

- (char)charValue {
    return self.numberValue.charValue;
}

- (unsigned char) unsignedCharValue {
    return self.numberValue.unsignedCharValue;
}

- (short)shortValue {
    return self.numberValue.shortValue;
}

- (unsigned short) unsignedShortValue {
    return self.numberValue.unsignedShortValue;
}

- (unsigned int)unsignedIntValue {
    return self.numberValue.unsignedIntValue;
}

- (long)longValue {
    return self.numberValue.longValue;
}

- (unsigned long) unsignedLongValue {
    return self.numberValue.unsignedLongValue;
}

- (unsigned long long) unsignedLongLongValue {
    return self.numberValue.unsignedLongLongValue;
}

- (NSUInteger)unsigendIntegerValue {
    return self.numberValue.unsignedIntegerValue;
}

+ (NSString *)stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (NSString *)stringWithUTF32Char:(UTF32Char)char32 {
    //转换为小端存储格式？？？
    char32 = NSSwapHostIntToLittle(char32);
    return [[NSString alloc] initWithBytes:&char32 length:4 encoding:NSUTF32LittleEndianStringEncoding];
}

+ (NSString *)stringWhitUTF32Chars:(const UTF32Char *)char32 length:(NSUInteger)length {
    return [[NSString alloc] initWithBytes:(const void *)char32
                                    length:length * 4
                                  encoding:NSUTF32LittleEndianStringEncoding];
}

- (void)enumerateUTF32CharInRange:(NSRange)range usingBlock:(void (^)(UTF32Char char32, NSRange range, BOOL *))block {
    NSString *str = self;
    if (range.location != 0 || range.length != self.length) {
        str = [self substringWithRange:range];
    }
    NSUInteger len = [str lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
    UTF32Char *char32 = (UTF32Char *)[str cStringUsingEncoding:NSUTF32LittleEndianStringEncoding];
    if (len == 0 || char32 == NULL) {
        return;
    }
    
    NSUInteger location = 0;
    BOOL stop = NO;
    NSRange subRange;
    UTF32Char oneChar;
    
    for (NSUInteger i = 0; i < len; i++) {
        oneChar = char32[i];
        subRange = NSMakeRange(location, oneChar > 0xFFFF ? 2 : 1);
        block(oneChar, subRange, &stop);
        if (stop) {
            return;
        }
        location += subRange.length;
    }
}

- (NSString *)stringByTrim {
    //去除两端的空格
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)stringByAppendingPathScale:(CGFloat)scale {
    if (fabs(scale - 1) <= __FLT_EPSILON__ || self.length == 0 || [self hasSuffix:@"/"]) {
        return self.copy;
    }
    NSString *ext = self.pathExtension;
    //icon.jpg
    NSRange extRange = NSMakeRange(self.length - ext.length, 0);
    if (ext.length > 0) {
        extRange.location -= 1;
    }
    NSString *scaleStr = [NSString stringWithFormat:@"@%@x", @(scale)];
    return [self stringByReplacingCharactersInRange:extRange withString:scaleStr];
}

- (CGFloat)pathScale {
    if (self.length == 0 || [self hasSuffix:@"/"]) {
        return 1;
    }
    NSString *name = self.stringByDeletingPathExtension;
    __block CGFloat scale = 1;
    [name enumerateRegexMatche:@"@[0-9]+\\.?[0-9]*x$" options:NSRegularExpressionAnchorsMatchLines usingBlock:^(NSString *match, NSRange matchRange, BOOL *stop) {
        scale = [match substringWithRange:NSMakeRange(1, match.length - 2)].doubleValue;
    }];
    return scale;
}

- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)containsString:(NSString *)string {
    if (string == nil) {
        return NO;
    }
    return [self rangeOfString:string].location != NSNotFound;
}

- (BOOL)containsCharacterSet:(NSCharacterSet *)set {
    if (set == nil) {
        return NO;
    }
    return [self rangeOfCharacterFromSet:set].location != NSNotFound;
}

- (NSNumber *)numberValue {
    return [NSNumber numberWithString:self];
}

- (NSData *)dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSRange)rangeOfAll {
    return NSMakeRange(0, self.length);
}

- (id)jsonValueDecoded {
    return [[self dataValue] jsonValueDecoded];
}

+ (NSString *)stringNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    if (!str) {
        path = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
        str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
    }
    return str;
}



@end
