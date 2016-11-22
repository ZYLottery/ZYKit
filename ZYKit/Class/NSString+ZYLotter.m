//
//  NSString+ZYLotter.m
//  ZYKit
//
//  Created by 何伟东 on 2016/11/22.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "NSString+ZYLotter.h"

@implementation NSString (ZYLotter)


/**
 将某段字符串处理成带富文本属性的字符串
 
 @param partOfStr 需要将字符串中那些子串进行处理
 @param color 处理成的颜色
 @param font 处理成的字体
 @return <#return value description#>
 */
- (NSMutableAttributedString *)mutableAttributedStringWithPartStr:(NSString *)partOfStr changeToColor:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    if(partOfStr.length){
        [attrStr addAttribute:NSFontAttributeName value:font range:[self rangeOfString:partOfStr]];
        [attrStr addAttribute:NSForegroundColorAttributeName value:color range:[self rangeOfString:partOfStr]];
    }
    return attrStr;
}


- (NSMutableAttributedString *)mutableAttributedStringWithPartStrRange:(NSRange)range changeToColor:(UIColor *)color font:(UIFont *)font{
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:self];
    [attrStr addAttribute:NSFontAttributeName value:font range:range];
    [attrStr addAttribute:NSForegroundColorAttributeName value:color range:range];
    return attrStr;
}

/**
 *  给字符串增加千位符
 *
 *  @param digitString <#digitString description#>
 *
 *  @return <#return value description#>
 */

+ (NSString *)separatedDigitStringWithStr:(NSString *)digitString{
    
    if (digitString.length <= 6) {
        return digitString;
    } else {
        NSString *string=[digitString substringToIndex:digitString.length-3];
        
        NSMutableString *processString = [NSMutableString stringWithString:string];
        NSInteger location = processString.length - 3;
        NSMutableArray *processArray = [NSMutableArray array];
        while (location >= 0) {
            NSString *temp = [processString substringWithRange:NSMakeRange(location, 3)];
            [processArray addObject:temp];
            if (location < 3 && location > 0)
            {
                NSString *t = [processString substringWithRange:NSMakeRange(0, location)];
                [processArray addObject:t];
            }
            location -= 3;
        }
        NSMutableArray *resultsArray = [NSMutableArray array];
        int k = 0;
        for (NSString *str in processArray)
        {
            k++;
            NSMutableString *tmp = [NSMutableString stringWithString:str];
            if (str.length > 2 && k < processArray.count )
            {
                [tmp insertString:@"," atIndex:0];
                [resultsArray addObject:tmp];
            } else {
                [resultsArray addObject:tmp];
            }
        }
        NSMutableString *resultString = [NSMutableString string];
        for (NSInteger i = resultsArray.count - 1 ; i >= 0; i--)
        {
            NSString *tmp = [resultsArray objectAtIndex:i];
            [resultString appendString:tmp];
        }
        return [resultString stringByAppendingString:[digitString substringFromIndex:digitString.length-3]];
    }
    
}

@end
