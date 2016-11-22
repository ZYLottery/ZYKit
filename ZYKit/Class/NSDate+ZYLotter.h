//
//  NSDate+Tool.h
//  GEDU_Demo
//
//  Created by Eric on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import <Foundation/Foundation.h>
static NSString *kNSDateHelperFormatSQLDateWithTime     = @"yyyy-MM-dd HH:mm:ss";
static NSString *kNSDateHelperFormatSQLDateNoSecondsWithTime     = @"yyyy-MM-dd HH:mm";
static NSString *kNSDateShortDate             = @"yyyy-MM-dd";
@class ZYCalender_Modal;
@interface NSDate (ZYLotter)
//是否是同一天
- (BOOL)isSameDay:(NSDate*)anotherDate;

- (NSInteger)secondsAgo;
- (NSInteger)minutesAgo;
- (NSInteger)hoursAgo;
- (NSInteger)monthsAgo;
- (NSInteger)yearsAgo;
/**
 *  多久之前
 *
 *  @return 多久字符串
 */
- (NSString *)stringTimesAgo;
- (NSString *)string_yyyy_MM_dd_EEE;
- (NSString *)stringTimeDisplay;

- (NSString *)defaultTimeStr;
- (NSString *)dayString;
- (NSString *)string_yyyy_MM_dd;
- (NSString *)string_a_HH_mm;
/**
 *  当前日期   可以改  自定义
 *
 *  @return ······
 */
- (NSString *)defaultchineseTimeStr;
/**
 *  是否是晚上
 *
 *  @return ····
 */
- (BOOL)isNight;
//当前是第几小时
- (NSInteger)currentHours;

+ (NSString *)convertStr_yyyy_MM_ddToDisplay:(NSString *)str_yyyy_MM_dd;
/**
 *  北京时间的时间戳转时间
 *
 *  @param time   时间戳字符串  10位
 *  @param format 格式  可以传nil  默认为@"yyyy-MM-dd HH:mm"
 *
 *  @return 时间格式
 */
+ (NSString *)convertBeijingTimeWithBeijingTimeStamp:(NSString *)time WithFormat:(NSString *)format;
/**
 *  得到北京时间的时间戳转
 *
 *  @param date  可以传nil  当前时间
 *
 *  @return 北京时间的时间戳转
 */
+ (NSString *)convertBeijingTimeWithDate:(NSDate*)date;
+ (NSDate *)getUTC_DateWithBeiJingLongTime:(NSString *)beijingTimeStamp;
+ (NSString *)getUTCTimeStampWithBeiJingLongTime:(NSString *)beijingTimeStamp;
/**
 *  得到一周时间
 *
 *  @param isBeginMonday 是否是从周一开始
 *  @param date          时间  nil为当前时间
 *
 *  @return isBeginMonday数组
 */
+ (NSArray *)getweekdaysWithBeginMonday:(BOOL)isBeginMonday withDate:(NSDate *)date;
/**
 *  得到开始日期 到结束日期的date
 *
 *  @param beginDate 开始日期
 *  @param endDate   结束日期
 *
 *  @return <#return value description#>
 */
+ (NSArray *)getDateModalsWithBeginDate:(NSDate *)beginDate withEndDate:(NSDate *)endDate;
/**
 *  得到开始日期 到结束日期的date
 *
 *  @param beginDate 开始日期
 *  @param endDate   结束日期
 *  @param displayDate 展示日期
 *  @param todayDate   今天日期
 *
 *  @return <#return value description#>
 */
+ (NSArray *)getDateModalsWithBeginDate:(NSDate *)beginDate withEndDate:(NSDate *)endDate dispalyDay:(NSString *)displayDate today:(NSString *)todayDate;
+ (NSArray *)getDateModalsWithCalenderModal:(ZYCalender_Modal *)calendermodal;
#pragma mark - 爆料列表时间格式
- (NSString *)stringNewsListTimeDisplay;
/**
 *  由 yyyy-MM-dd HH:mm:ss 转化成  HH:mm
 *
 *  @param timeString yyyy-MM-dd HH:mm:ss
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringHH_mmDisplayWithDateHelperFormatSQLDateWithTimeString:(NSString *)timeString;
/**
 *  由 yyyy-MM-dd HH:mm:ss 转化成  MM-dd HH:mm
 *
 *  @param timeString yyyy-MM-dd HH:mm:ss
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringMM_dd_HH_mmDisplayWithDateHelperFormatSQLDateWithTimeString:(NSString *)timeString;
@end
