//
//  UIButton+ZYKit.m
//  ZYKit
//
//  Created by 何伟东 on 2016/11/15.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "UIButton+ZYKit.h"
#import <WDKit/WDKit.h>

@implementation UIButton (ZYKit)

+ (UIButton *)zy_buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block{
    UIButton * btn = [[UIButton alloc]init];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:color forState:UIControlStateNormal];
    if (block) {
        [btn handlerControlEvent:UIControlEventTouchUpInside handler:block];
    }
    if (selectedColor) {
        [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (selectedtitle) {
        [btn setTitle:title forState:UIControlStateSelected];
    }
    if (image) {
        [btn setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [btn setImage:selectedImage forState:UIControlStateSelected];
    }
    return btn;
}

+ (UIButton *)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block{
    return  [self zy_buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:nil selectedImage:nil withBlock:block];
}

+ (UIButton *)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block{
    return  [self zy_buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:image selectedImage:nil withBlock:block];
}
- (void)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block{
    [self zy_buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:nil selectedImage:nil withBlock:block];
}
- (void)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block{
    [self zy_buttonWithNormalTitle:title selectedTitle:nil font:font NormaltitleColor:color selectedTitleColor:nil normalImage:image selectedImage:nil withBlock:block];
}
- (void)zy_buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block{
    [self setTitle:title forState:UIControlStateNormal];
    self.titleLabel.font = font;
    [self setTitleColor:color forState:UIControlStateNormal];
    if (block) {
        [self handlerControlEvent:UIControlEventTouchUpInside handler:block];
    }
    if (selectedColor) {
        [self setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    if (selectedtitle) {
        [self setTitle:title forState:UIControlStateSelected];
    }
    if (image) {
        [self setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [self setImage:selectedImage forState:UIControlStateSelected];
    }
}
/**
 *  设置不同状态背景颜色
 *
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageWithColor:backgroundColor] forState:state];
    
}



@end
