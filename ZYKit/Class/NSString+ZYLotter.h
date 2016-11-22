//
//  NSString+ZYLotter.h
//  ZYKit
//
//  Created by 何伟东 on 2016/11/22.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ZYLotter)


/**
 将某段字符串处理成带富文本属性的字符串

 @param partOfStr 需要将字符串中那些子串进行处理
 @param color 处理成的颜色
 @param font 处理成的字体
 @return <#return value description#>
 */
- (NSMutableAttributedString *)mutableAttributedStringWithPartStr:(NSString *)partOfStr changeToColor:(UIColor *)color font:(UIFont *)font;
- (NSMutableAttributedString *)mutableAttributedStringWithPartStrRange:(NSRange)range changeToColor:(UIColor *)color font:(UIFont *)font;

/**
 *  给字符串增加千位符
 *
 *  @param digitString <#digitString description#>
 *
 *  @return <#return value description#>
 */

+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString;


@end
