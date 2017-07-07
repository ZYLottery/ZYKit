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
 按指定的大小颜色生成图片
 
 @param color <#color description#>
 @param size <#size description#>
 @return <#return value description#>
 */
+(UIImage*)imageWithColor:(UIColor*)color size:(CGSize)size;
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


/**
 图片合成
 
 @param topImage 上边图片
 @param bottomImage 上边图片
 @param margin 两者间隔
 @return <#return value description#>
 */
+ (UIImage *) combineWithTopImg:(UIImage*)topImage
                      bottomImg:(UIImage*)bottomImage
                     withMargin:(NSInteger)margin
                          scale:(CGFloat)scale;

/**
 <#Description#>

 @param topImage    <#topImage description#>
 @param bottomImage <#bottomImage description#>
 @param ImageWidth    图片的宽
 @param scale       <#scale description#>

 @return <#return value description#>
 */
+ (UIImage *) combineWithTopImg:(UIImage*)topImage
                      bottomImg:(UIImage*)bottomImage
                       ImageWidth:(float)imageWidth
                          scale:(CGFloat)scale;
/**
 截取屏幕某一部分图片
 
 @param frame <#frame description#>
 @return <#return value description#>
 */
+(UIImage *)fullScreenshots:(CGSize)frame;


@end
