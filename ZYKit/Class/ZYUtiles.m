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
