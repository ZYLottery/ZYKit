//
//  ZYUtiles.m
//  ZYKit
//
//  Created by 何伟东 on 2017/2/17.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import "ZYUtiles.h"
#import <SDWebImage/SDWebImageManager.h>
 #import <objc/runtime.h>
#import <MJExtension/MJExtension.h>
@implementation ZYUtiles


/**
 获取sdwebImage缓存  如果没有下载图片
 */
+(void)loadImageWithUrl:(NSString *)picUrl finishBlock:(ZYGetSDWebCacheWithFinishedBlock)finishBlock{
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:picUrl]];
    SDImageCache* cache = [SDImageCache sharedImageCache];
    //此方法会先从memory中取。
    UIImage * cacheImage = [cache imageFromCacheForKey:key];
    if (cacheImage) {
        finishBlock(cacheImage);
        return;
    }
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:picUrl] options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        if (finished&&image) {
            [[SDWebImageManager sharedManager] saveImageToCache:image forURL:imageURL];
            
        }
        finishBlock(image);
    }];

}

/**
 动态获取一个类
 
 @param nameForclass 类名
 @param propertys 属性
 @return id类型  可能为nil  nil时是没有此类型
 */
+ (id)getClassWithClassName:(NSString *)nameForclass propertys:(NSDictionary *)propertys;{
    // 类名
    NSString *class =[NSString stringWithFormat:@"%@", nameForclass];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass){
        return nil;//无此类
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    // 对该对象赋值属性
    if (propertys) {
        //mj 会便利所有属性  并没此属性的setValue不会出错  里面有相关判断操作
        [instance mj_setKeyValues:propertys];
    }
    return instance;
}
@end
