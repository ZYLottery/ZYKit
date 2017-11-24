//
//  UIImageView+KKimageViewWithCornerRadius.m
//  KeKeEnglish
//
//  Created by 关旭航 on 16/4/15.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "UIImageView+ZYLotter.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>
#import "UIImage+ZYLotter.h"


CGFloat const kLBBlurredImageDefaultBlurRadius            = 20.0;
CGFloat const kLBBlurredImageDefaultSaturationDeltaFactor = 1.8;
static BOOL noPic = NO;//是否省流量 不加载图片  暂放  以后有需求  放全局变量
@implementation UIImageView (ZYLotter)
- (void)zy_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius{
    NSURL *url;
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }

    url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        } else {
              __weak typeof (self) tempSelf = self;
            [self sd_setImageWithURL:url placeholderImage:placeHolderStr?[UIImage imageNamed:placeHolderStr]:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    UIImage *radiusImage = [UIImage createRoundedRectImage:image size:tempSelf.frame.size radius:radius];
                    tempSelf.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr completion:^{
                        //清除原有非圆角图片缓存
                        [[SDImageCache sharedImageCache] removeImageForKey:urlStr withCompletion:^{
                            
                        }];
                    }];
                }
            }];
        }
    }
    else {
        [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:placeHolderStr] completed:nil];
    }
}
- (void)zy_loadImageUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    [self sd_setImageWithURL:url placeholderImage:placeHolderStr?[UIImage imageNamed:placeHolderStr]:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
- (void)zy_loadImageUrlStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    [self sd_setImageWithURL:url placeholderImage:nil  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
}
- (void)zy_loadImageUrlStr:(NSString *)urlStr radius:(CGFloat)radius{
    NSURL *url;
    //这里传CGFLOAT_MIN，就是默认以图片宽度的一半为圆角
    if (radius == CGFLOAT_MIN) {
        radius = self.frame.size.width/2.0;
    }
    
    url = [NSURL URLWithString:urlStr];
    
    if (radius != 0.0) {
        //头像需要手动缓存处理成圆角的图片
        NSString *cacheurlStr = [urlStr stringByAppendingString:@"radiusCache"];
        UIImage *cacheImage = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:cacheurlStr];
        if (cacheImage) {
            self.image = cacheImage;
        }
        else {
            __weak typeof (self) tempSelf = self;
            [self sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if (!error) {
                    UIImage *radiusImage = [UIImage createRoundedRectImage:image size:tempSelf.frame.size radius:radius];
                    tempSelf.image = radiusImage;
                    [[SDImageCache sharedImageCache] storeImage:radiusImage forKey:cacheurlStr completion:^{
                        [[SDImageCache sharedImageCache] removeImageForKey:urlStr withCompletion:^{
                            
                        }];
                    }];
                }
            }];
        }
    }else {
        [self sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
    }
}

- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr{
    
    if(noPic){
        [self zy_loadImageUrlStr:urlStr placeHolderImageName:placeHolderStr];
    }else{
        if (placeHolderStr) {
            self.image = [UIImage imageNamed:placeHolderStr];
        }
        
    }
}
- (void)kkloadImageButControlUrlStr:(NSString *)urlStr placeHolderImageName:(NSString *)placeHolderStr radius:(CGFloat)radius{
    if(noPic){
        [self zy_loadImageUrlStr:urlStr placeHolderImageName:placeHolderStr radius:radius];
    }else{
        if (placeHolderStr) {
            self.image = [UIImage imageNamed:placeHolderStr];
        }
    }

}
#pragma mark - LBBlurredImage Additions

- (void)setImageToBlur:(UIImage *)image
       completionBlock:(LBBlurredImageCompletionBlock)completion
{
    [self setImageToBlur:image
              blurRadius:kLBBlurredImageDefaultBlurRadius
         completionBlock:completion];
}

- (void)setImageToBlur:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
       completionBlock:(LBBlurredImageCompletionBlock) completion
{
    NSParameterAssert(image);
    NSParameterAssert(blurRadius >= 0);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *blurredImage = [image applyBlurWithRadius:blurRadius
                                                 tintColor:nil
                                     saturationDeltaFactor:kLBBlurredImageDefaultSaturationDeltaFactor
                                                 maskImage:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = blurredImage;
            if (completion) {
                completion();
            }
        });
    });
}
@end
