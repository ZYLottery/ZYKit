//
//  UIImageView+KKimageViewWithCornerRadius.h
//  KeKeEnglish
//
//  Created by 关旭航 on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LBBlurredImageCompletionBlock)(void);

extern CGFloat const kLBBlurredImageDefaultBlurRadius;
@interface UIImageView (ZYLotter)
/**
 *  外层封装sdwebimage 外加圆角需求
 *
 *  @param urlStr         ·····
 *  @param placeHolderStr ·····
 *  @param radius         ·····
 */
- (void)zy_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius;
- (void)zy_loadImageUrlStr:(NSString *)urlStr radius:(CGFloat)radius;
- (void)zy_loadImageUrlStr:(NSString *)urlStr;
- (void)zy_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr;
/**
 *  加载图片  但是全局控制  关闭省流量
 *
 *  @param urlStr         url
 *  @param placeHolderStr 占位图
 */
- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr;
- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius;
#pragma mark - 毛玻璃效果
/**
 Set the blurred version of the provided image to the UIImageView
 
 @param UIImage the image to blur and set as UIImageView's image
 @param CGFLoat the radius of the blur used by the Gaussian filter
 @param LBBlurredImageCompletionBlock a completion block called after the image
 was blurred and set to the UIImageView (the block is dispatched on main thread)
 */
- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(LBBlurredImageCompletionBlock)completion;

/**
 Set the blurred version of the provided image to the UIImageView
 with the default blur radius
 
 @param UIImage the image to blur and set as UIImageView's image
 @param LBBlurredImageCompletionBlock a completion block called after the image
 was blurred and set to the UIImageView (the block is dispatched on main thread)
 */
- (void)setImageToBlur:(UIImage *)image
       completionBlock:(LBBlurredImageCompletionBlock)completion;
@end
