//
//  UIDevice+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/26.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface UIDevice (Add)

+ (double)systemVersion;

@property (nonatomic, readonly) BOOL isPad;

@property (nonatomic, readonly) BOOL isSimulator;

@property (nonatomic, readonly) BOOL isJailbroken;

@property (nonatomic, readonly) BOOL canMakePhoneCalls NS_EXTENSION_UNAVAILABLE_IOS("");

@property (nullable, nonatomic, readonly) NSString *machineModel;

@property (nullable, nonatomic, readonly) NSString *machineModelName;

@property (nonatomic, readonly) NSDate *systemUptime;

@property (nullable, nonatomic, readonly) NSString *ipAddressWIFI;

@property (nullable, nonatomic, readonly) NSString *ipAddressCell;


typedef NS_OPTIONS(NSUInteger, YYNetworkTrafficType) {
    YYNetworkTrafficTypeWWANSent     = 1 << 0,
    YYNetworkTrafficTypeWWANReceived = 1 << 1,
    YYNetworkTrafficTypeWIFISent     = 1 << 2,
    YYNetworkTrafficTypeWIFIReceived = 1 << 3,
    YYNetworkTrafficTypeAWDLSent     = 1 << 4,
    YYNetworkTrafficTypeAWDLReceived = 1 << 5,
    
    YYNetworkTrafficTypeWWAN = YYNetworkTrafficTypeWWANSent | YYNetworkTrafficTypeWWANReceived,
    YYNetworkTrafficTypeWIFI = YYNetworkTrafficTypeWIFISent | YYNetworkTrafficTypeWIFIReceived,
    YYNetworkTrafficTypeAWDL = YYNetworkTrafficTypeAWDLSent | YYNetworkTrafficTypeAWDLReceived,
    
    YYNetworkTrafficTypeALL = YYNetworkTrafficTypeWWAN |
                              YYNetworkTrafficTypeWIFI |
                              YYNetworkTrafficTypeAWDL,
};

- (uint64_t)getNetworkTraffocBytes:(YYNetworkTrafficType)types;

@property (nonatomic, readonly) int64_t diskSpace;
@property (nonatomic, readonly) int64_t diskSpaceFree;
@property (nonatomic, readonly) int64_t diskSpaceUsed;






@end
NS_ASSUME_NONNULL_END
