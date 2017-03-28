//
//  ZYUtiles.h
//  ZYKit
//
//  Created by 何伟东 on 2017/2/17.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYUtiles : NSObject
typedef void(^ZYGetSDWebCacheWithFinishedBlock)(UIImage *image);
/**
 获取app当前视图所在的viewController
 
 @return <#return value description#>
 */
+(UIViewController *)getCurrentViewController;
/**
   获取sdwebImage缓存  如果没有下载图片
 */
+(void)loadImageWithUrl:(NSString *)picUrl finishBlock:(ZYGetSDWebCacheWithFinishedBlock)finishBlock;
@end
