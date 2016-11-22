//
//  NSDate+Tool.m
//  GEDU_Demo
//
//  Created by 关旭航 on 14/10/29.
//  Copyright (c) 2014年 Eric. All rights reserved.
//

#import "NSDate+ZYLotter.h"
#import "NSDate+Helper.h"
#import "ZYDateModal.h"
#import "ZYCalender_Modal.h"
@implementation NSDate (ZYLotter)

- (BOOL)isSameDay:(NSDate*)anotherDate{
    if(anotherDate==nil){
        anotherDate = [NSDate date];
    }
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components1 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:self];
    NSDateComponents* components2 = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:anotherDate];
    return ([components1 year] == [components2 year] && [components1 month] == [components2 month] && [components1 day] == [components2 day]);
}
- (NSInteger)secondsAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSSecondCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components second];
}
- (NSInteger)minutesAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSMinuteCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components minute];
}
- (NSInteger)hoursAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components hour];
}
- (NSInteger)monthsAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components month];
}

- (NSInteger)yearsAgo{
    NSCalendar *calendar = [[self class] sharedCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit)
                                               fromDate:self
                                                 toDate:[NSDate date]
                                                options:0];
    return [components year];
}

- (NSString *)stringTimesAgo{
    if ([self compare:[NSDate date]] == NSOrderedDescending) {
        return @"刚刚";
    }
    
    NSString *text = nil;
    
    NSInteger agoCount = [self monthsAgo];
    if (agoCount > 0) {
//        text = [NSString stringWithFormat:@"%ld个月前", (long)agoCount];
        text = [self defaultTimeStr];
    }else{
        agoCount = [self daysAgoAgainstMidnight];
        if (agoCount > 0) {
            NSInteger agoH = [self hoursAgo];
            NSInteger leftH = agoH%24;
            if(leftH >0){
                text = [NSString stringWithFormat:@"%ld天%ld小时前", (long)agoCount,(long)leftH];
            }else{
                text = [NSString stringWithFormat:@"%ld天前", (long)agoCount];
            }
            
            if(agoCount >3){
                text = [self defaultTimeStr];
            }
         
            
        }else{
            agoCount = [self hoursAgo];
            if (agoCount > 0) {
              NSInteger agomin = [self minutesAgo];
                NSInteger leftmin = agomin%60;
                if(leftmin >0){
                  text = [NSString stringWithFormat:@"%ld小时%ld分钟前", (long)agoCount,(long)leftmin];
                }else{
                   text = [NSString stringWithFormat:@"%ld小时前", (long)agoCount];
                }
            }else{
                agoCount = [self minutesAgo];
                if (agoCount > 0) {
                    text = [NSString stringWithFormat:@"%ld分钟前", (long)agoCount];
                }else{
                    agoCount = [self secondsAgo];
                    if (agoCount > 15) {
                        text = [NSString stringWithFormat:@"%ld秒前", (long)agoCount];
                    }else{
                        text = @"刚刚";
                    }
                }
            }
        }
    }
    return text;
}

- (NSString *)string_yyyy_MM_dd_EEE{
    NSString *text = [self stringWithFormat:@"yyyy-MM-dd EEE"];
    NSInteger daysAgo = [self daysAgoAgainstMidnight];
    switch (daysAgo) {
        case 0:
            text = [text stringByAppendingString:@"（今天）"];
            break;
        case 1:
            text = [text stringByAppendingString:@"（昨天）"];
            break;
        default:
            break;
    }
    return text;
}
- (NSString *)stringTimeDisplay{
    NSString *text = nil;
    NSInteger daysAgo = [self daysAgoAgainstMidnight];
    NSString *dateStr;
    switch (daysAgo) {
        case 0:
            dateStr = @"今天";
            break;
        case 1:
            dateStr = @"昨天";
            break;
        default:
            dateStr = [self stringWithFormat:@"MM-dd"];
            break;
    }
    text = [NSString stringWithFormat:@"%@ %@", dateStr, [self string_a_HH_mm]];
    return text;
    
    //    NSString *text = nil;
    //    NSInteger daysAgo = [self daysAgoAgainstMidnight];
    //    switch (daysAgo) {
    //        case 0:
    //            text = [NSString stringWithFormat:@"今天 %@", [self stringWithFormat:@"a hh:mm"]];
    //            break;
    //        case 1:
    //            text = [NSString stringWithFormat:@"昨天 %@", [self stringWithFormat:@"a hh:mm"]];
    //            break;
    //        default:
    //            text = [self stringWithFormat:@"MM-dd a hh:mm"];
    //            break;
    //    }
    //    text = [text stringByReplacingOccurrencesOfString:@"上午 12" withString:@"上午 00"];
    //    return text;
}
#pragma mark - 爆料列表时间格式
- (NSString *)stringNewsListTimeDisplay{
    NSInteger daysAgo = [self zy_daysAgoAgainstMidnight];
    NSString *dateStr;
    switch (daysAgo) {
        case 0:
            dateStr = [NSString stringWithFormat:@"今天 %@",[self stringWithFormat:@"HH:mm"]];
            break;
        default:
            dateStr = [NSString stringWithFormat:@"%d月%d日 %@",(int)[self month],(int)[self day],[self stringWithFormat:@"HH:mm"]];
            break;
    }
    return dateStr;
}
- (NSUInteger)zy_daysAgoAgainstMidnight {
    // get a midnight version of ourself:
    NSDateFormatter *mdf = [[self class] sharedDateFormatter];
    [mdf setDateFormat:@"yyyy-MM-dd"];
    NSDate *midnight = [mdf dateFromString:[mdf stringFromDate:self]];
    NSInteger daysAgo = 0;
    if ([midnight timeIntervalSinceNow]<=0) {
        daysAgo = (int)[midnight timeIntervalSinceNow] /(60*60*24) *-1;
    }else{
        daysAgo = (int)[midnight timeIntervalSinceNow] /(60*60*24) *-1 -1;
    }
    return daysAgo;
}
/**
 *  由 yyyy-MM-dd HH:mm:ss 转化成  HH:mm
 *
 *  @param timeString yyyy-MM-dd HH:mm:ss
 *
 *  @return <#return value description#>
 */
+ (NSString *)stringHH_mmDisplayWithDateHelperFormatSQLDateWithTimeString:(NSString *)timeString{
    if (timeString&&timeString.length>15) {
        NSString * last = [[timeString componentsSeparatedByString:@" "] lastObject];
        if (last.length>6) {
            return [last substringToIndex:5];
        }
    }
    return @"";
}
+ (NSString *)stringMM_dd_HH_mmDisplayWithDateHelperFormatSQLDateWithTimeString:(NSString *)timeString{
    if (timeString&&timeString.length>15) {
        return [timeString substringWithRange:NSMakeRange(5,timeString.length-5-3)];
    }
    return @"";
}
- (NSString *)defaultTimeStr
{
    NSString *str;
    //日期
//    if ([self isSameDay:[NSDate new]]) {
//        str = [self string_a_HH_mm];
//    }else{
        str = [self string_yyyy_MM_dd];
//    }

    return str;
}
//自定义
- (NSString *)defaultchineseTimeStr
{
    NSString *str;
    //日期
    if ([self isSameDay:[NSDate new]]) {
        str = [self string_a_HH_mm];
    }else{
        str = [self stringyyyyMMdd];
    }

    return str;
}



- (NSString *)stringyyyyMMdd{
    return [self stringWithFormat:@"yyyy年MM月dd日"];
}

- (NSString *)dayString{
   return [self stringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)string_yyyy_MM_dd{
    return [self stringWithFormat:@"yyyy-MM-dd HH:mm"];
}

- (NSString *)string_a_HH_mm{
    NSString *text = nil;
    NSString *aStr, *timeStr;
    timeStr = [self stringWithFormat:@"hh:mm"];
    NSUInteger hour = [self hour];
    if (hour < 3) {
        aStr = @"凌晨";
    }else if (hour >= 3 && hour < 12){
        aStr = @"上午";
    }else if (hour >= 12 && hour < 13){
        aStr = @"中午";
    }else if (hour >= 13 && hour < 18){
        aStr = @"下午";
    }else{
        aStr = @"晚上";
    }
    text = [NSString stringWithFormat:@"%@ %@", aStr, timeStr];
    return text;
}
+ (NSString *)convertStr_yyyy_MM_ddToDisplay:(NSString *)str_yyyy_MM_dd{
    NSString *displayStr = @"";
    if (str_yyyy_MM_dd && str_yyyy_MM_dd.length > 0) {
        NSDate *date = [NSDate dateFromString:str_yyyy_MM_dd withFormat:@"yyyy-MM-dd"];
        if (date) {
            NSDate *today = [NSDate dateFromString:[[NSDate date] stringWithFormat:@"yyyy-MM-dd"] withFormat:@"yyyy-MM-dd"];
            if ([date year] != [today year]) {
                displayStr = [date stringWithFormat:@"yyyy年MM月dd日"];
            }else{
                NSCalendar *calendar = [[self class] sharedCalendar];
                NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                                           fromDate:today
                                                             toDate:date
                                                            options:0];
                NSInteger leftDayCount = [components day];
                switch (leftDayCount) {
                    case 2:
                        displayStr = @"后天";
                        break;
                    case 1:
                        displayStr = @"明天";
                        break;
                    case 0:
                        displayStr = @"今天";
                        break;
                    case -1:
                        displayStr = @"昨天";
                        break;
                    case -2:
                        displayStr = @"前天";
                        break;
                    default:
                        displayStr = [date stringWithFormat:@"MM月dd日"];
                        break;
                }
            }
        }
        
    }
    return displayStr;
}

//是不是晚上
- (BOOL)isNight{
    NSUInteger hour = [self hour];
    if(hour >=22 || hour <6){
        return YES;
    }else{
        return NO;
    }
}

- (NSInteger)currentHours{
    return [self hour];
}
+ (NSString *)convertBeijingTimeWithBeijingTimeStamp:(NSString *)time WithFormat:(NSString *)format{
    // NSLog(@"time& %@",time);
    long long  t = [time longLongValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    if (format==nil) {
        format = kNSDateHelperFormatSQLDateNoSecondsWithTime;
    }
    [formatter setDateFormat:format];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(t)];
    return [formatter stringFromDate:confromTimesp];
}
+ (NSString *)convertBeijingTimeWithDate:(NSDate*)date{
    if (date ==nil) {
        date = [NSDate date];
        NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
        [dateformat setDateFormat:kNSDateHelperFormatSQLDateWithTime];
        NSString * newDateOne = [dateformat stringFromDate:date];
        [dateformat setFormatterBehavior:NSDateFormatterBehaviorDefault
         ];
        [dateformat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
        date = [dateformat dateFromString:newDateOne];
    }
    NSString * myDate = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]]];
    NSString *timeSp = myDate;
    return timeSp;
}
+ (NSDate *)getUTC_DateWithBeiJingLongTime:(NSString *)longTime{
    return [NSDate dateFromString:[NSDate convertBeijingTimeWithBeijingTimeStamp:longTime WithFormat:kNSDateHelperFormatSQLDateNoSecondsWithTime] withFormat:kNSDateHelperFormatSQLDateNoSecondsWithTime];
}
+ (NSString *)getUTCTimeStampWithBeiJingLongTime:(NSString *)beijingTimeStamp{
    NSDate * date = [self getUTC_DateWithBeiJingLongTime:beijingTimeStamp];
    return [NSString stringWithFormat:@"%ld",[date utcTimeStamp]];
}
/**
 *  得到一周时间
 *
 *  @param isBeginMonday 是否是从周一开始
 *  @param date          时间  nil为当前时间
 *
 *  @return isBeginMonday数组
 */
+ (NSArray *)getweekdaysWithBeginMonday:(BOOL)isBeginMonday withDate:(NSDate *)date
{
    if (date==nil) {
        date = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    else{
        date = [NSDate dateWithTimeInterval:0 sinceDate:date];
    }
    NSMutableArray * datas = [[NSMutableArray alloc]init];
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSDateComponents * comps= [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:date];
    int weekday =(int)comps.weekday;
    if (isBeginMonday) {
        if (weekday==1) {
            weekday=7;
        }
        else{
            weekday--;
        }
    }
    for (int i =1; i<=7; i++) {
      
        int temp = i-weekday;
        NSDate * mydate = [NSDate dateWithTimeInterval:temp*3600 * 24 sinceDate:date];
        ZYDateModal * modal = [[ZYDateModal alloc]initWithDate:mydate];
        [datas addObject:modal];
        
    }
    return datas;
}
+ (NSArray *)getDateModalsWithBeginDate:(NSDate *)beginDate withEndDate:(NSDate *)endDate{
    NSMutableArray * dates = [[NSMutableArray alloc]init];
    long beginDateTimeStamp = [beginDate utcTimeStamp];
    long endDateTimeStamp = [endDate utcTimeStamp];
    for(long i = beginDateTimeStamp;i<=endDateTimeStamp;i+=3600*24){
        NSDate * date = [NSDate dateWithTimeIntervalSinceNow:i];
        ZYDateModal * modal = [[ZYDateModal alloc] initWithDate:date];
        [dates addObject:modal];
    }
    return dates;
}
+ (NSArray *)getDateModalsWithBeginDate:(NSDate *)beginDate withEndDate:(NSDate *)endDate dispalyDay:(NSString *)displayDate today:(NSString *)todayDate{
    NSMutableArray * dates = [[NSMutableArray alloc]init];
    long beginDateTimeStamp = [beginDate utcTimeStamp];
    long endDateTimeStamp = [endDate utcTimeStamp];
     long displayDateTimeStamp = [[NSDate dateFromString:displayDate withFormat:kNSDateShortDate] utcTimeStamp];
     long todayDateTimeStamp = [[NSDate dateFromString:todayDate withFormat:kNSDateShortDate] utcTimeStamp];
    for(long i = beginDateTimeStamp;i<=endDateTimeStamp;i+=3600*24){
        NSDate * date = [NSDate dateWithTimeIntervalSince1970:i];
        ZYDateModal * modal = [[ZYDateModal alloc] initWithDate:date];
        modal.isToday = (i==todayDateTimeStamp);
        modal.isDisPlay = (i==displayDateTimeStamp);
        [dates addObject:modal];
    }
    return dates;
}
+ (NSArray *)getDateModalsWithCalenderModal:(ZYCalender_Modal *)calendermodal{
    
    return [self getDateModalsWithBeginDate:[NSDate dateFromString:calendermodal.startDay withFormat:kNSDateShortDate] withEndDate:[NSDate dateFromString:calendermodal.endDay withFormat:kNSDateShortDate] dispalyDay:calendermodal.displayDay today:calendermodal.today];
}
@end
