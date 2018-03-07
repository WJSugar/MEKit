//
//  NSDictionary+Add.m
//  MEKit
//
//  Created by jinghua on 16/12/14.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "NSDictionary+Add.h"
#import "NSString+Add.h"
#import "NSData+Add.h"
#import "YYKitMacro.h"
YYSYNTH_DUMMY_CLASS(NSDictionary_Add)

@interface __XMLDictionaryParser : NSObject <NSXMLParserDelegate>
@end

@implementation __XMLDictionaryParser {
    NSMutableDictionary *_root;
    NSMutableArray *_stack;
    NSMutableString *_text;
}

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    [parser setDelegate:self];
    [parser parse];
    return self;
}

- (instancetype)initWithString:(NSString *)xml {
    NSData *data = [xml dataUsingEncoding:NSUTF8StringEncoding];
    return [self initWithData:data];
}

- (NSDictionary *)result {
    return _root;
}

#pragma mark - NSXMLParserDelegate

#define XMLText @"_text"
#define XMLName @"_name"
#define XMLPref @"_"

- (void)textEnd {
    _text = _text.stringByTrim.mutableCopy;
    if (_text.length) {
        NSMutableDictionary *top = _stack.lastObject;
        id existing = top[XMLText];
        if ([existing isKindOfClass:[NSArray class]]) {
            [existing addObject:_text];
        } else if (existing) {
            top[XMLText] = [@[existing, _text] mutableCopy];
        } else {
            top[XMLText] = _text;
        }
    }
    _text = nil;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    [self textEnd];
    
    NSMutableDictionary *node = [NSMutableDictionary new];
    if (!_root) {
        node[XMLName] = elementName;
    }
    if (attributeDict.count) {
        [node addEntriesFromDictionary:attributeDict];
    }
    if (_root) {
        NSMutableDictionary *top = _stack.lastObject;
        id existing = top[elementName];
        if ([existing isKindOfClass:[NSArray class]]) {
            [existing addObject:node];
        } else if (existing) {
            top[elementName] = [@[existing, node] mutableCopy];
        } else {
            top[elementName] = node;
        }
        [_stack addObject:node];
    } else {
        _root = node;
        _stack = [NSMutableArray arrayWithObject:node];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    [self textEnd];
    
    NSMutableDictionary *top = _stack.lastObject;
    [_stack removeLastObject];
    
    NSMutableDictionary *left = top.mutableCopy;
    [left removeObjectsForKeys:@[XMLText, XMLName]];
    for (NSString *key in left.allKeys) {
        if ([key hasPrefix:XMLPref]) {
            [left removeObjectForKey:key];
            left[[key substringFromIndex:XMLPref.length]] = top[key];
        }
    }
    if (left.count) {
        return;
    }
    
    NSMutableDictionary *children = top.mutableCopy;
    [children removeObjectsForKeys:@[XMLText, XMLName]];
    for (NSString *key in children.allKeys) {
        if ([key hasPrefix:XMLPref]) {
            [children removeObjectForKey:key];
        }
    }
    if (children.count) {
        return;
    }
    
    NSMutableDictionary *topNew = _stack.lastObject;
    NSString *nodeName = top[XMLName];
    if (!nodeName) {
        for (NSString *name in topNew) {
            id object = topNew[name];
            if (object == top) {
                nodeName = name; break;
            } else if ([object isKindOfClass:[NSArray class]] && [object containsObject:top]) {
                nodeName = name; break;
            }
        }
    }
    if (!nodeName) {
        return;
    }
    
    id inner = top[XMLText];
    if ([inner isKindOfClass:[NSArray class]]) {
        inner = [inner componentsJoinedByString:@"\n"];
    }
    if (!inner) {
        return;
    }
    
    id parent = topNew[nodeName];
    if ([parent isKindOfClass:[NSArray class]]) {
        NSArray *parentAsArray = parent;
        parent[parentAsArray.count - 1] = inner;
    } else {
        topNew[nodeName] = inner;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (_text) {
        [_text appendString:string];
    } else {
        _text = [NSMutableString stringWithString:string];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    if (_text) {
        [_text appendString:string];
    } else {
        _text = [NSMutableString stringWithString:string];
    }
}
#undef XMLText
#undef XMLName
#undef XMLPref
@end


@implementation NSDictionary (Add)

+ (NSDictionary *)dictionaryWithPlistData:(NSData *)plist {
    if (!plist) {
        return nil;
    }
    NSDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListImmutable format:NULL error:NULL];
    if ([dictionary isKindOfClass:[NSDictionary class]]) {
        return dictionary;
    }
    return nil;
}

+ (NSDictionary *)dictionaryWithPlistString:(NSString *)plist {
    if (!plist) {
        return nil;
    }
    NSData *data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithPlistData:data];
}

- (NSData *)plistData {
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListBinaryFormat_v1_0 options:kNilOptions error:NULL];
}

- (NSString *)plistString {
    NSData *xmlData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
    if (xmlData) {
        return xmlData.utf8String;
    }
    return nil;
}

- (NSArray *)allKeysSorted {
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

- (NSArray *)allValuesSortedByKeys {
    NSArray *sortedKeys = [self allKeysSorted];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    for (id  key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return [arr copy];
}

- (BOOL)containsObjectForKey:(id)key {
    if (!key) {
        return NO;
    }
    return self[key] != nil;
}

- (NSDictionary *)entriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            dic[key] = value;
        }
    }
    return [dic copy];
}

- (NSString *)jsonStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) {
            return json;
        }
    }
    return nil;
}

- (NSString *)jsonPrettyStringEncoded {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) {
            return json;
        }
    }
    return nil;
}

+ (NSDictionary *)dictionaryWithXML:(id)xml {
    __XMLDictionaryParser *parser = nil;
    if ([xml isKindOfClass:[NSString class]]) {
        parser = [[__XMLDictionaryParser alloc] initWithString:xml];
    } else if ([xml isKindOfClass:[NSData class]]) {
        parser = [[__XMLDictionaryParser alloc] initWithData:xml];
    }
    return [parser result];
}

static NSNumber *NSNumberFormID(id value) {
    static NSCharacterSet *dot;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //????
        dot = [NSCharacterSet characterSetWithRange:NSMakeRange('.', 1)];
    });
    if (!value || value == [NSNull null]) {
        return nil;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        NSString *lower = ((NSString *)value).lowercaseString;
        if ([lower isEqualToString:@"true"] || [lower isEqualToString:@"yes"]) {
            return @(YES);
        }
        if ([lower isEqualToString:@"false"] || [lower isEqualToString:@"no"]) {
            return @(NO);
        }
        if ([lower isEqualToString:@"nil"] || [lower isEqualToString:@"null"]) {
            return nil;
        }
        if ([(NSString *)value rangeOfCharacterFromSet:dot].location != NSNotFound) {
            return @(((NSString *)value).doubleValue);//有小数点
        } else {
            return @(((NSString *)value).longLongValue); //没有小数点
        }
    }
    return nil;
}

#define RETURN_VALUE(_type_)\
if (!key) return def;\
id value = self[key];\
if (!value || value == [NSNull null]) return def;\
if ([value isKindOfClass:[NSNumber class]]) return ((NSNumber *)value)._type_;\
if ([value isKindOfClass:[NSString class]]) return NSNumberFormID(value)._type_;\
return def;

- (BOOL)boolValueForKey:(NSString *)key default:(BOOL)def {
    RETURN_VALUE(boolValue);
}

- (char)charValueForKey:(NSString *)key default:(char)def {
    RETURN_VALUE(charValue);
}

- (unsigned char)unsignedCharValueForKey:(NSString *)key default:(unsigned char)def {
    RETURN_VALUE(unsignedCharValue);
}

- (short)shortValueForKey:(NSString *)key default:(short)def {
    RETURN_VALUE(shortValue);
}

- (unsigned short)unsignedShortValueForKey:(NSString *)key default:(unsigned short)def {
    RETURN_VALUE(unsignedShortValue);
}

- (int)intValueForKey:(NSString *)key default:(int)def {
    RETURN_VALUE(intValue);
}

- (unsigned int)unsignedIntValueForKey:(NSString *)key default:(unsigned int)def {
    RETURN_VALUE(unsignedIntValue);
}

- (long)longValueForKey:(NSString *)key default:(long)def {
    RETURN_VALUE(longValue);
}

- (unsigned long)unsignedLongValueForKey:(NSString *)key default:(unsigned long)def {
    RETURN_VALUE(unsignedLongValue);
}

- (long long)longLongValueForKey:(NSString *)key default:(long long)def {
    RETURN_VALUE(longLongValue);
}

- (unsigned long long)unsignedLongLongValueForKey:(NSString *)key default:(unsigned long long)def {
    RETURN_VALUE(unsignedLongLongValue);
}

- (float)floatValueForKey:(NSString *)key default:(float)def {
    RETURN_VALUE(floatValue);
}

- (double)doubleValueForKey:(NSString *)key default:(double)def {
    RETURN_VALUE(doubleValue);
}

- (NSInteger)intergerValueForKey:(NSString *)key default:(NSInteger)def {
    RETURN_VALUE(integerValue);
}

- (NSUInteger)unsignedIntegerValueForKey:(NSString *)key default:(NSUInteger)def {
    RETURN_VALUE(unsignedIntegerValue);
}
- (NSNumber *)numberValueForKey:(NSString *)key default:(NSNumber *)def {
    if (!key) {
        return def;
    }
    id value = self[key];
    if (!value || value == [NSNull null]) {
        return def;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return NSNumberFormID(value);
    }
    return def;
}

- (NSString *)stringValueForKey:(NSString *)key default:(NSString *)def {
    if (!key) {
        return def;
    }
    id value = self[key];
    if (!value || value == [NSNull null]) {
        return def;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return ((NSNumber *)value).description;
    }
    return def;
}
@end


@implementation NSMutableDictionary(Add)

+ (NSMutableDictionary *)dictionaryWithPlistData:(NSData *)plist {
    if (!plist) {
        return nil;
    }
    NSMutableDictionary *dictionary = [NSPropertyListSerialization propertyListWithData:plist options:NSPropertyListMutableContainersAndLeaves format:NULL error:NULL];
    if ([dictionary isKindOfClass:[NSMutableDictionary class]]) {
        return dictionary;
    }
    return nil;
}

+ (NSMutableDictionary *)dictionaryWithPlistString:(NSString *)plist {
    if (!plist) {
        return nil;
    }
    NSData *data = [plist dataUsingEncoding:NSUTF8StringEncoding];
    return [self dictionaryWithPlistData:data];
}

- (id)popObjectForKey:(id)aKey {
    if (!aKey) {
        return nil;
    }
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}

- (NSDictionary *)popEntriesForKeys:(NSArray *)keys {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (id key in keys) {
        id value = self[key];
        if (value) {
            [self removeObjectForKey:key];
            dic[key] = value;
        }
    }
    return [dic copy];
}

@end










