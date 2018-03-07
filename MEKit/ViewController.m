//
//  ViewController.m
//  MEKit
//
//  Created by jinghua on 16/11/3.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import "NSData+Add.h"
#import "NSNumber+Add.h"
#import "NSString+Add.h"
#import "NSArray+Add.h"
#import "NSDate+Add.h"

@interface ViewController () {
    NSInteger _ticketCount;
    NSLock *_mutexLock;
    NSRecursiveLock *_recurLock;
    NSConditionLock *_conditionLock;
    NSCondition *_condition;
    NSMutableArray *_products;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDate *date = [NSDate date];
    NSLog(@"%@", [date dateByAddingYears:1]);
//    NSMethodSignature *sig = [NextViewController instanceMethodForSelector:@selector(getWifiName)];
//    if (!sig) {
//        return;
//    }
//    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sig];
//    inv.target = self;
//    inv.selector = @selector(getWifiName);
//    NSString *way = @"params";
//    [inv setArgument:&way atIndex:2];
//    [inv invoke];
//    UILabel *label = [UILabel new];
//    label.frame = CGRectMake(0, 70, 400, 50);
//    label.text = @"新华社北京电新华社北京电新华社北京电";
//    label.font = [UIFont systemFontOfSize:30];
//    label.backgroundColor = [UIColor redColor];
//    label.baselineAdjustment = UIBaselineAdjustmentAlignBaselines;
//    [self.view addSubview:label];
//    label.adjustsFontSizeToFitWidth = YES;
//    
//    UILabel *label2 = [UILabel new];
//    label2.frame = CGRectMake(0, 70 + 50 + 20, 400, 50);
//    label2.text = @"新华社北京电新华社北京电新华社北京电";
//    label2.font = [UIFont systemFontOfSize:30];
//    label2.backgroundColor = [UIColor redColor];
//    label2.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
//    [self.view addSubview:label2];
//    label2.adjustsFontSizeToFitWidth = YES;
//
//    
//    UILabel *label3 = [UILabel new];
//    label3.frame = CGRectMake(0, 70 + 50 + 20 + 50 + 20, 400, 50);
//    label3.text = @"新华社北京电新华社北京电新华社北京电";
//    label3.font = [UIFont systemFontOfSize:30];
//    label3.backgroundColor = [UIColor redColor];
//    label3.baselineAdjustment = UIBaselineAdjustmentNone;
//    [self.view addSubview:label3];
//    label3.adjustsFontSizeToFitWidth = YES;
    
//    NSData *testData = [@"apple" dataUsingEncoding:NSUTF8StringEncoding];
//    Byte *bytes = (Byte *)[testData bytes];
//    for (int i = 0; i < testData.length; i++) {
//        
//    }
//    NSString *html = @"<p>　　新华社北京12月8日电（记者吴晶、胡浩）全国高校思想政治工作会议12月7日至8日在北京召开。中共中央总书记、国家主席、中央军委主席习近平出席会议并发表重要讲话。他强调，高校思想政治工作关系高校培养什么样的人、如何培养人以及为谁培养人这个根本问题。要坚持把立德树人作为中心环节，把思想政治工作贯穿教育教学全过程，实现全程育人、全方位育人，努力开创我国高等教育事业发展新局面。</p><p>　　中共中央政治局常委、中央书记处书记刘云山作总结讲话。中共中央政治局常委王岐山、张高丽出席会议。</p>";
//    NSString *formattString = [html stringByEscapingHTML];
//    NSLog(@"============%@", html);
//    NSLog(@"============%@", formattString);
//    NSString *string = @"jinghua";
//    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"%ld", data.length);
//    NSLog(@"%@", data);
//    
//    NSString *jinghua = [data hexString];
//    NSLog(@"%@", jinghua);
//    
//    NSData *newData = [NSData dataWithHexString:@"6A696E67687561"];
//    NSLog(@"%@", newData);
//    
//    NSNumber *str = [NSNumber numberWithString:@"no"];
//    NSLog(@"%@", str);
    
    
//锁的相关学习
//    _ticketCount = 10;
//    _mutexLock = [[NSLock alloc] init];
//    _recurLock = [[NSRecursiveLock alloc] init];
//    _conditionLock = [[NSConditionLock alloc] init];
//    _condition = [[NSCondition alloc] init];
//    _products = [NSMutableArray array];
//    
//    [NSThread detachNewThreadSelector:@selector(product) toTarget:self withObject:nil];
//    [NSThread detachNewThreadSelector:@selector(consume) toTarget:self withObject:nil];
    
//    NSThread *threadOne = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets1) object:nil];
//    threadOne.name = @"threadOne";
//    
//    NSThread *threadTwo = [[NSThread alloc] initWithTarget:self selector:@selector(sellTickets2) object:nil];
//    threadTwo.name = @"threadTwo";
//    
//    [threadOne start];
//    [threadTwo start];
}

- (NSString *)getWifiName {
    NSString *wifiName = nil;
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            NSLog(@"network info -> %@", networkInfo);
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            CFRelease(dictRef);
        }
    }
    CFRelease(wifiInterfaces);
    return wifiName;
}

//- (void)consume {
//    while (1) {
//        [NSThread sleepForTimeInterval:arc4random() % 10 * 0.1 + 1.5];
//        [_condition lock];
//        while (_products.count == 0) {
//            NSLog(@"商品数目为0，等待生产");
//            [_condition wait];
//        }
//        [_products removeLastObject];
//        [_condition signal];
//        [_condition unlock];
//    }
//}
//
//- (void)product {
//    while (1) {
//        [NSThread sleepForTimeInterval:arc4random() % 10 * 0.1 + 0.5];
//        [_condition lock];
//        while (_products.count > 2) {
//            NSLog(@"商品满了，等待消费");
//            [_condition wait];
//        }
//        [_products addObject:[NSObject new]];
//        NSLog(@"生产了一个商品,商品数%ld",_products.count);
//        [_condition signal];
//        [_condition unlock];
//    }
//}

//- (void)sellTickets1 {
//    for (int i = 0; i < 5; i++) {
//        [NSThread sleepForTimeInterval:1];
//        [_conditionLock lock];
//        NSLog(@"%d", i);
//        [_conditionLock unlockWithCondition:i];
//    }
//}
//- (void)sellTickets2 {
//    [_conditionLock lockWhenCondition:2];
//    NSLog(@"thread");
//    [_conditionLock unlock];
//}

//- (void)sellTickets {
//    NSLog(@"%@",[NSThread currentThread]);
//    while (1) {
//        [NSThread sleepForTimeInterval:1];
//        [_recurLock lock];
//        if (_ticketCount) {
//            _ticketCount--;
//            NSLog(@"%ld", _ticketCount);
//        } else {
//            NSLog(@"票卖完了");
//            break;
//        }
//        [_recurLock unlock];
//    }
//}

//- (void)sellTickets {
//    NSObject *obejct = [NSObject new];
//    NSLog(@"%@",[NSThread currentThread]);
//    while (1) {
//        @synchronized (obejct) {
//            [NSThread sleepForTimeInterval:1];
//            if (_ticketCount) {
//                _ticketCount--;
//                NSLog(@"%ld", _ticketCount);
//            } else {
//                NSLog(@"票卖完了");
//                break;
//            }
//        }
//    }
//}
@end
