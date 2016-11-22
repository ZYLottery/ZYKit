//
//  ZYDateModal.h
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/16.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>

@interface ZYDateModal : NSObject
@property(nonatomic,copy) NSString * weekDayString1;
@property(nonatomic,copy) NSString * weekDayString2;
@property(nonatomic,assign)int  day;
@property(nonatomic,assign)int  month;
@property(nonatomic,assign)int  year;
@property(nonatomic,assign)int  weakDay;
@property(nonatomic,copy)NSDate *  date;
@property(nonatomic,copy)NSString * dateline;
//短日期 YYYY-mm-dd
@property(nonatomic,copy)NSString * shortdateFortmatString;
@property(nonatomic,copy)NSString * defineFormatString;
- (void)setDefineFormatStringWithFormart:(NSString *)format;
/**
 *  初始化
 *
 *  @param date date可以传nil 当前时间
 *
 *  @return ······
 */
- (instancetype)initWithDate:(NSDate *)date;
/**
 *  附加属性 不一定有
 */
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)BOOL isToday;
@property(nonatomic,assign)BOOL isDisPlay;
@end
