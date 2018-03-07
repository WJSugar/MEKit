//
//  NSDate+Add.h
//  MEKit
//
//  Created by jinghua on 16/12/20.
//  Copyright © 2016年 Sugar. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
@interface NSDate (Add)
@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month;
@property (nonatomic, readonly) NSInteger day;
@property (nonatomic, readonly) NSInteger hour;
@property (nonatomic, readonly) NSInteger minute;
@property (nonatomic, readonly) NSInteger second;
@property (nonatomic, readonly) NSInteger nanosecond;//毫微秒
@property (nonatomic, readonly) NSInteger weekday;

@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth;
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;
@property (nonatomic, readonly) BOOL isLeapMonth;
@property (nonatomic, readonly) BOOL isLeapYear;
@property (nonatomic, readonly) BOOL isToday;
@property (nonatomic, readonly) BOOL isYesterday;

- (nullable NSDate *)dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;


- (nullable NSString *)stringWithFormat:(NSString *)format;
- (nullable NSString *)stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;
- (nullable NSString *)stringWithISOFormat;
+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;
+ (nullable NSDate *)dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;

+ (nullable NSDate *)dateWithISOFormatString:(NSString *)dateString;

@end
NS_ASSUME_NONNULL_END
