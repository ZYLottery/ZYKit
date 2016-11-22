//
//  ZYDateModal.m
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/16.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYDateModal.h"
#import "NSDate+ZYLotter.h"

@implementation ZYDateModal
MJCodingImplementation
- (instancetype)initWithDate:(NSDate *)date{
    self = [super init];
    if (self) {
        if (date==nil) {
            date = [NSDate date];
        }
        NSCalendar * calendar = [NSCalendar currentCalendar];
        NSDateComponents * dateComponents= [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:date];
        switch (dateComponents.weekday) {
            case 1:
            {
                self.weekDayString1 = @"日";
                self.weekDayString2 = @"周日";
            }
                break;
            case 2:
            {
                self.weekDayString1 = @"一";
                self.weekDayString2 = @"周一";
            }
                break;
            case 3:
            {
                self.weekDayString1 = @"二";
                 self.weekDayString2 = @"周二";
            }
                break;
            case 4:
            {
                self.weekDayString1 = @"三";
                 self.weekDayString2 = @"周三";
            }
                break;
            case 5:
            {
                self.weekDayString1 = @"四";
                 self.weekDayString2 = @"周四";
            }
                break;
            case 6:
            {
                self.weekDayString1 = @"五";
                 self.weekDayString2 = @"周五";
            }
                break;
            case 7:
            {
                self.weekDayString1 = @"六";
                self.weekDayString2 = @"周六";
            }
                break;
            default:
                break;
        }
        self.day = (int)dateComponents.day;
        self.month = (int)dateComponents.month;
        self.year = (int)dateComponents.year;
        self.weakDay = (int)dateComponents.weekday;
        self.date = date;
        self.shortdateFortmatString = [self.date stringWithFormat:kNSDateShortDate];
        self.dateline = [NSString stringWithFormat:@"%ld",(long)[self.date utcTimeStamp]] ;
    }
    return self;
}
- (void)setDefineFormatStringWithFormart:(NSString *)format{
    self.defineFormatString = [self.date stringWithFormat:format];
}
@end
