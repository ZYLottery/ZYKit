//
//  UIButton+ZYLotter.h
//  ZYKit
//
//  Created by 何伟东 on 2016/11/15.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (ZYLotter)

/**
 *  快捷创建btn
 *
 */
+ (UIButton *)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block;
+ (UIButton *)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block;
+ (UIButton *)zy_buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block;
/**
 *  设置btn
 *
 */
- (void)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color withBlock:(void(^)(id sender))block;
- (void)zy_buttonWithTitle:(NSString *)title font:(UIFont *)font titleColor:(UIColor *)color normalImage:(UIImage *)image withBlock:(void(^)(id sender))block;
- (void)zy_buttonWithNormalTitle:(NSString *)title selectedTitle:(NSString *)selectedtitle font:(UIFont *)font NormaltitleColor:(UIColor *)color selectedTitleColor:(UIColor *)selectedColor normalImage:(UIImage *)image selectedImage:(UIImage *)selectedImage withBlock:(void(^)(id sender))block;
/**
 *  设置不同状态背景颜色
 *
 */
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;


@end
