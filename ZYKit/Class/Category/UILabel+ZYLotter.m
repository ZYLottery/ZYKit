//
//  UILabel+ZYLotter.m
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/16.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "UILabel+ZYLotter.h"

@implementation UILabel (ZYLotter)
+ (UILabel *)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color{
    UILabel * label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color;
    label.textAlignment = textAlignment;
    label.font = font;
    return label;
}
-(void)labelWithTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment font:(UIFont *)font color:(UIColor*)color{
    self.text = title;
    self.textColor = color;
    self.textAlignment = textAlignment;
    self.font = font;
}
/**
 *  加某一个字符串的某个字符的字间距
 *
 *  @param substr 摸个字符
 *  @param number 间距
 *
 *  @return <#return value description#>
 */

- (void)addKernAttributeForSubStr:(NSString *)substr  value:(int)number{
    NSMutableAttributedString * attrString= [self.attributedText mutableCopy];
    NSRegularExpression *urlRegex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@".%@",substr] options:NSRegularExpressionCaseInsensitive error:nil];
    [urlRegex enumerateMatchesInString:self.text options:0 range:NSMakeRange(0, [self.text length]) usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
        NSRange range = result.range;
        [attrString addAttribute:NSKernAttributeName value:@(number) range:range ];
    }];
    self.attributedText = attrString;
}
@end
