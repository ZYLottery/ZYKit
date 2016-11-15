//
//  UIImage+ZYLotter.h
//  ZYLottery
//
//  Created by 何伟东 on 5/11/16.
//  Copyright © 2016 章鱼彩票. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZYLotter)

/**
 *  传入图片放缓一个像素大小的UIImage图片
 *
 *  @param color <#color description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*)imageWithColor:(UIColor*)color;
/**
 *  生成圆角图片
 *
 *  @param image ····
 *  @param size  ····
 *  @param r     弧度
 *
 *  @return ·····
 */
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r;
- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;
@end
