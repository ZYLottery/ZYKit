//
//  ZYUtiles.m
//  ZYKit
//
//  Created by 何伟东 on 2017/2/17.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import "ZYUtiles.h"
#import <SDWebImage/SDWebImageManager.h>
@implementation ZYUtiles


/**
 获取app当前视图所在的viewController

 @return <#return value description#>
 */
+(UIViewController *)getCurrentViewController{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    //如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }else{
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        //UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result = nav.childViewControllers.lastObject;
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}
/**
 获取sdwebImage缓存  如果没有下载图片
 */
+(void)loadImageWithUrl:(NSString *)picUrl finishBlock:(ZYGetSDWebCacheWithFinishedBlock)finishBlock{
    if ([[SDWebImageManager sharedManager] diskImageExistsForURL:[NSURL URLWithString:picUrl]]) {
        UIImage * image =  [[SDWebImageManager sharedManager].imageCache imageFromDiskCacheForKey:[[SDWebImageManager sharedManager] cacheKeyForURL:[NSURL URLWithString:picUrl]]];
        finishBlock(image);
        
    }else{
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:picUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
           
            if (finished&&image) {
                [[SDWebImageManager sharedManager] saveImageToCache:image forURL:imageURL];
               
            }
            finishBlock(image);
            
        }];
    }
}
@end
