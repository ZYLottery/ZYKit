//
//  UILabel+ZYLotter.h
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/16.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZYLotter)
/**
 *  创建Label
 *
 */
+ (UILabel *)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color;
-(void)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color;
/**
 *  加某一个字符串的某个字符的字间距
 *
 *  @param substr 摸个字符
 *  @param number 间距
 *
 *  @return <#return value description#>
 */

- (void)addKernAttributeForSubStr:(NSString *)substr  value:(int)number;
@end
