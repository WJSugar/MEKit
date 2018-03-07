//
//  NSData+Add.m
//  MEKit
//
//  Created by jinghua on 16/11/3.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSData+Add.h"
#include <CommonCrypto/CommonCrypto.h>
#import "YYKitMacro.h"
#include <zlib.h>

YYSYNTH_DUMMY_CLASS(NSData_Add)

@implementation NSData (Add)

- (NSString *)md2String {
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSData *)md2Data {
    unsigned char result[CC_MD2_DIGEST_LENGTH];
    CC_MD2(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD2_DIGEST_LENGTH];
}

- (NSString *)md4String {
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSData *)md4Data {
    unsigned char result[CC_MD4_DIGEST_LENGTH];
    CC_MD4(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD4_DIGEST_LENGTH];
}

- (NSString *)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSData *)md5Data {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)sha1String {
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)sha1Data {
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)sha224String {
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)sha224Data {
    unsigned char result[CC_SHA224_DIGEST_LENGTH];
    CC_SHA224(self.bytes, (CC_LONG)self.bytes, result);
    return [NSData dataWithBytes:result length:CC_SHA224_DIGEST_LENGTH];
}

- (NSString *)sha256String {
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA256_DIGEST_LENGTH];
    for (int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)sha256Data {
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)sha384String {
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.length, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA384_DIGEST_LENGTH];
    for (int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)sha384Data {
    unsigned char result[CC_SHA384_DIGEST_LENGTH];
    CC_SHA384(self.bytes, (CC_LONG)self.bytes, result);
    return [NSData dataWithBytes:result length:CC_SHA384_DIGEST_LENGTH];
}

- (NSString *)sha512String {
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.bytes, result);
    NSMutableString *hash = [NSMutableString
                             stringWithCapacity:CC_SHA512_DIGEST_LENGTH];
    for (int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)sha512Data {
    unsigned char result[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(self.bytes, (CC_LONG)self.length, result);
    return [NSData dataWithBytes:result length:CC_SHA512_DIGEST_LENGTH];
}

- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5:    size = CC_MD5_DIGEST_LENGTH;    break;
        case kCCHmacAlgSHA1:   size = CC_SHA1_DIGEST_LENGTH;   break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)hmacDataUsingAlg:(CCHmacAlgorithm)alg withKey:(NSData *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5:    size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1:   size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    CCHmac(alg, key.bytes, key.length, self.bytes, self.length, result);
    return [NSData dataWithBytes:result length:size];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

- (NSData *)hmacMD5DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgMD5 withKey:key];
}

- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSData *)hmacSHA1DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSData *)hmacSHA224DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSData *)hmacSHA256DataWithKey:(NSData *)key {
    return [self hmacSHA256DataWithKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSData *)hmacSHA384DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

- (NSData *)hmacSHA512DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

- (NSString *)crc32String {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return [NSString stringWithFormat:@"%08x", (uint32_t)result];
}

- (uint32_t)crc32 {
    uLong result = crc32(0, self.bytes, (uInt)self.length);
    return (uint32_t)result;
}

- (NSData *)aes256EncryptWithKey:(NSData *)key iv:(NSData *)iv {
    // key的长度必须为16 24 32这几个值中的一个
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    // iv 为空或者长度为16
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    //初始化一个data
    NSData *result = nil;
    //
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    //申请内存空间
    void *buffer = malloc(bufferSize);
    if (!buffer) {
        return nil;
    }
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,//加密
                                          kCCAlgorithmAES128,//AES加密算法
                                          kCCOptionPKCS7Padding,//kCCOptionPKCS7Padding就代表了CBC加密模kCCOptionPKCS7Padding|kCCOptionECBMode，就表示运用了ECB加密模式
                                          key.bytes,//key
                                          key.length,//key大小
                                          iv.bytes,//iv
                                          self.bytes,//iv的bytes
                                          self.length,//data的长度
                                          buffer,//结果
                                          bufferSize,//结果长度
                                          &encryptedSize);//如果成功，这个的值为bufferSize的长度，根据执行的结果返回的长度不同  ?????？
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc] initWithBytes: buffer length:encryptedSize];
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

- (NSData *)aes256DencryptWithKey:(NSData *)key iv:(NSData *)iv {
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (iv.length != 16 && iv.length != 16) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = self.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) {
        return nil;
    }
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding,
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          self.bytes,
                                          self.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc] initWithBytesNoCopy:buffer length:encryptedSize];
        free(buffer);
        return nil;
    } else {
        free(buffer);
        return nil;
    }
}

- (NSString *)utf8String {
    if (self.length > 0) {
        return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
    }
    return @"";
}

- (NSString *)hexString {
    //获取data的字节数
    NSUInteger length = self.length;
    //一个字符的长度是两个字节，因此 length个字节，转化为字符的话需要2 * length个字节的长度进行存储
    NSMutableString *result = [NSMutableString stringWithCapacity:length * 2];
    //获取到data的内存的首地址
    const unsigned char *byte = self.bytes;
    for (int i = 0; i < length; i++, byte++) {
        //遍历这个data并将其拼接到可变字符串上 02X = 02不足两位的用0补足两位，X表示以十六进制输入
        [result appendFormat:@"%02X", *byte];
    }
    return result;
}

+ (NSData *)dataWithHexString:(NSString *)hexString {
    //去除空格
    hexString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    //转为小写
    hexString = [hexString lowercaseString];
    //获取字符串长度
    NSUInteger len = hexString.length;
    if (!len) {
        return nil;
    }
    //申请内存
    unichar *buf = malloc(sizeof(unichar) * len);
    if (!buf) {
        return nil;
    }
    //将字符逐写入buf中
    [hexString getCharacters:buf range:NSMakeRange(0, len)];
    //初始化一个可变的data
    NSMutableData *result = [NSMutableData data];
    
    unsigned char bytes;
    //初始化一个长度为3的char类型的数组
    char str[3] = { '\0', '\0', '\0'};
    //len / 2 例如：jinghua长度为7，len / 2 = 3
    for (int i = 0; i < len / 2; i++) {
        //将buffer中的字符全部取出来放入到str数组的前连个元素中
        //i = 0 - 0
        //i = 1 - 2
        //i = n - 2 * n
        str[0] = buf[i * 2];
        //i = 0 - 1
        //i = 1 - 3
        //i = 2 * n + 1
        str[1] = buf[i * 2 + 1];
        //strtol 将str转换为16进制的整数
        bytes = strtol(str, NULL, 16);
        //将这个字节拼接到可数组中
        [result appendBytes:&bytes length:1];
    }
    //释放buf
    free(buf);
    return result;
}

static const char base64EncodingTable[64]
= "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short base64DecodingTable[256] = {
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2,  -1,  -1, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62,  -2,  -2, -2, 63,
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2,  -2,  -2, -2, -2,
    -2, 0,  1,  2,  3,  4,  5,  6,  7,  8,  9,  10,  11,  12, 13, 14,
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2,  -2,  -2, -2, -2,
    -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36,  37,  38, 39, 40,
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2,
    -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,  -2,  -2, -2, -2
};

- (NSString *)base64EncodedString {
    //获取到data的长度
    NSUInteger length = self.length;
    if (length == 0) {
        return @"";
    }
    //base64的原理是将 3 * 8 = 4 * 6
    //因此可以知道输出的长度为 length + 2 当length = 1的时候， lengt / 3 = 0这个时候，没有意义，所以，至少为3的倍数，因此可以得出out_length的长度是以下公式所得
    NSUInteger out_length = ((length + 2) / 3) * 4;
    //申请一个转化结束后的内存空间 ？？？？?
    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
    if (output == NULL) {
        return nil;
    }
/*
 1.s13
 2.转成ASCII码：115  49  51
 3.将ASCII转换成二进制表示 01110011   001100001  00110011 (3 X  8)
 4.6个一组  01110011   001100001  00110011
 5.现在的分组状况为 011100  110011  0000100  110011
 6.8个二进制位为一个字节，所以将以上的最高的前两位加0补位
 7.将补位得到的数字 00011100  00110011  000000100  00110011 转化成为十进制
 8.28   51  4  51
 9.对应base的表得到了对应的表示c Z E z
 10.结束
 */
    //输入的data指针
    const char *input = self.bytes;
    NSInteger i, value;
    for (i = 0; i < length; i++) {
        value = 0;
        for (NSInteger j = i; j < i; j++) {
            // 将value左移8位 相当于value * 2的八次方
            value <<= 8;
            if (j < length) {
                //(0xFF & input[j]) 按位与0xFF即：1111 1111 对应位进行二进制计算
                // |= (0xFF & input[j]) 后面与前面的value进行按位或，并赋值给value
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = ((i + 1) < length)
        ? base64EncodingTable[(value >> 6) & 0x3F] : '=';
        output[index + 3] = ((i + 1) < length)
        ? base64EncodingTable[(value >> 0) & 0x3F] : '=';
    }
    NSString *base64 = [[NSString alloc] initWithBytes:output
                                                length:out_length
                                              encoding:NSASCIIStringEncoding];
    free(output);
    return base64;
}

- (id)jsonValueDecoded {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValueDecoded error:%@", error);
    }
    return value;
}

//解压zip
- (NSData *)gzipInflate {
    if ([self length] == 0) {
        return self;
    }
    
    unsigned full_length = (unsigned)[self length];
    unsigned half_length = (unsigned)[self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    

    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (unsigned)[self length];
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit2(&strm, (15 + 32)) != Z_OK) {
        return nil;
    }
    while (!done) {
        //保证足够的空间
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy:half_length];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if (status != Z_OK){
            break;
        }
    }
    if (inflateEnd(&strm) != Z_OK) {
        return nil;
    }
    
    //设置真正的长度
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    } else {
        return nil;
    }
}

- (NSData *)gzipDeflate {
    if ([self length] == 0) {
        return self;
    }
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree =  Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self length];
    
    //   Z_NO_COMPRESSION
    //   Z_BEST_SPEED
    //   Z_BEST_COMPRESSION
    //   Z_DEFAULT_COMPRESSION
    if (deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED, (15 + 16),
                     8, Z_DEFAULT_STRATEGY) != Z_OK) {
        return nil;
    }
    //16k chunks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    do {
        if (strm.total_out >= [compressed length]) {
            [compressed increaseLengthBy:16384];
        }
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    } while (strm.avail_out == 0);
    
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

- (NSData *)zlibInflate {
    if ([self length] == 0) {
        return self;
    }
    NSUInteger full_length = [self length];
    NSUInteger half_length = [self length] / 2;
    
    NSMutableData *decompressed = [NSMutableData dataWithLength:full_length + half_length];
    BOOL done = NO;
    int status;
    
    z_stream strm;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)full_length;
    strm.total_out = 0;
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    
    if (inflateInit(&strm) != Z_OK) {
        return nil;
    }
    while (!done) {
        if (strm.total_out >= [decompressed length]) {
            [decompressed increaseLengthBy:half_length];
        }
        strm.next_out = [decompressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([decompressed length] - strm.total_out);
        
        status = inflate(&strm, Z_SYNC_FLUSH);
        if (status == Z_STREAM_END) {
            done = YES;
        } else if(status != Z_OK){
            return nil;
        }
    }
    if (inflateEnd(&strm) != Z_OK) {
        return nil;
    }
    if (done) {
        [decompressed setLength:strm.total_out];
        return [NSData dataWithData:decompressed];
    } else {
        return nil;
    }
}

- (NSData *)zlibDeflate {
    if ([self length] == 0) {
        return self;
    }
    
    z_stream strm;
    
    strm.zalloc = Z_NULL;
    strm.zfree = Z_NULL;
    strm.opaque = Z_NULL;
    strm.total_out = 0;
    strm.next_in = (Bytef *)[self bytes];
    strm.avail_in = (uInt)[self bytes];
    
    if (deflateInit(&strm, Z_DEFAULT_COMPRESSION) != Z_OK) {
        return nil;
    }
    
    //16k chunks for expansion
    NSMutableData *compressed = [NSMutableData dataWithLength:16384];
    
    do {
        if (strm.total_out >= [compressed length]) {
            [compressed increaseLengthBy:16384];
        }
        strm.next_out = [compressed mutableBytes] + strm.total_out;
        strm.avail_out = (uInt)([compressed length] - strm.total_out);
        
        deflate(&strm, Z_FINISH);
    } while (strm.avail_out == 0);
    deflateEnd(&strm);
    
    [compressed setLength:strm.total_out];
    return [NSData dataWithData:compressed];
}

+ (NSData *)dataNamed:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@""];
    if (!path) {
        return nil;
    }
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}

@end
