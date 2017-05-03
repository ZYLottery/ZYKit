//
//  ZYClientInfo.h
//  ZYKit
//
//  Created by 何伟东 on 2016/11/17.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZYClientInfo : NSObject


/**
 *  设备的IMEI号
 */
@property(nonatomic,strong) NSString *imei;
/**
 *  终端设备型号(各种手机型号等)
 */
@property(nonatomic,strong) NSString *deviceCode;
/**
 *  操作系统类型	iOS/Android等
 */
@property(nonatomic,strong) NSString *osType;
/**
 *  操作系统版本	iOS版本、安卓版本等
 */
@property(nonatomic,strong) NSString *osVersion;
/**
 *  类似浏览器的UA概念
 */
@property(nonatomic,strong) NSString *userAgent;
/**
 *  客户端平台	客户端的平台 iOS/Android/h5/PC/乐视iOS/xxx/yyy
 */
@property(nonatomic,strong) NSString *platform;
/**
 *  客户端版本号
 */
@property(nonatomic,strong) NSString *version;
/**
 *  客户端数字版本代号	用于判断更新
 */
@property(nonatomic) int versionCode;
/**
 *  客户端来源渠道
 */
@property(nonatomic,strong) NSString *channel;
/**
 *  产品名称或代号	产品代号(Web, GameWeb之类的概念)
 */
@property(nonatomic,strong) NSString *product;
/**
 *  来源	扩展的来源属性, 根据业务需求使用
 */
@property(nonatomic,strong) NSString *source;

/**
 *  广告追踪
 */
@property(nonatomic,strong) NSString *idfa;
/**
 *  屏幕的宽度
 */
@property(nonatomic,strong) NSNumber *screenWidth;
/**
 *  屏幕的高度
 */
@property(nonatomic,strong) NSNumber *screenHeight;
/**
 *  app下载跟踪的cookie
 */
@property(nonatomic,strong) NSString *cookieData;

/**
 用户id
 */
@property(nonatomic,strong) NSString *userOpenId;


/**
 *  获取idfa
 *
 *  @return <#return value description#>
 */
+ (NSString*)getIDFA;

/**
 默认clientInfo
 
 @param productId 外部变量
 @param channelId 外部变量
 @return <#return value description#>
 */
+(ZYClientInfo*)clentInfoWithpProductId:(NSString*)productId
                              channelId:(NSString*)channelId
                                 userId:(NSString*)userId;

@end
