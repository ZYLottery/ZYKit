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
   获取sdwebImage缓存  如果没有下载图片
 */
+(void)loadImageWithUrl:(NSString *)picUrl finishBlock:(ZYGetSDWebCacheWithFinishedBlock)finishBlock;


/**
  动态获取一个类

 @param nameForclass 类名
 @param propertys 属性
 @return id类型  可能为nil  nil时是没有此类型
 */
+ (id)getClassWithClassName:(NSString *)nameForclass propertys:(NSDictionary *)propertys;

@end
