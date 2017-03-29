//
//  ZYMessageDataModel.h
//  ZYService
//
//  Created by guanxuhang1234 on 2017/2/28.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZYAlertMessageDataModel : NSObject

/**
 标题
 */
@property(nonatomic,copy)NSString * title;

/**
 无字段则不显示
 */
@property(nonatomic,copy)NSString * content;

/**
 本地预存储的图片名，本地无图片则使用picUrl网络加载
 */
@property(nonatomic,copy)NSString * picKey;


/**
 图片地址
 */
@property(nonatomic,copy)NSString * picUrl;


/**
 图片高度
 */
@property(nonatomic,assign)float picHeight;

/**
 图片宽度
 */
@property(nonatomic,assign)float picWidth;

/**
 是否有 关闭按钮
 */
@property(nonatomic,assign)BOOL closable;

/**
 主按钮文字
 */
@property(nonatomic,copy)NSString * primaryButton;
/**
 次按钮文字
 */
@property(nonatomic,copy)NSString * secondaryButton;

/**
 回传信息
 */
@property(nonatomic,copy)NSString * extraData;
@end
