//
//  ZYAnalyticsClientInfo.h
//  ZYKit
//
//  Created by 何伟东 on 2017/5/3.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYAnalyticsClientInfo : NSObject

/**
 产品代号
 */
@property(nonatomic,strong) NSString *product;
/**
 客户端平台
 */
@property(nonatomic,strong) NSString *platform;

/**
 操作系统类型
 */
@property(nonatomic,strong) NSString *os_type;

/**
 操作系统版本
 */
@property(nonatomic,strong) NSString *os_version;

/**
 客户端版本
 */
@property(nonatomic,strong) NSString *version;

/**
 数字版本号
 */
@property(nonatomic,strong) NSString *version_code;

/**
 客户端信息
 */
@property(nonatomic,strong) NSString *imei;

/**
 终端设备型号
 */
@property(nonatomic,strong) NSString *device_code;

/**
 UA
 */
@property(nonatomic,strong) NSString *user_agent;

/**
 客户端来源渠道
 */
@property(nonatomic,strong) NSString *channel;

/**
 扩展来源属性
 */
@property(nonatomic,strong) NSString *source;

/**
 外部链接
 */
@property(nonatomic,strong) NSString *referrer;

/**
 android_id
 */
@property(nonatomic,strong) NSString *android_id;

/**
 mac
 */
@property(nonatomic,strong) NSString *mac;

/**
 参考API-Client-ID
 */
@property(nonatomic,strong) NSString *app_client_id;

/**
 idfa
 */
@property(nonatomic,strong) NSString *idfa;

/**
 app环境qa,dev,release
 */
@property(nonatomic,strong) NSString *environment;

/**
 generate client information

 @param productId <#productId description#>
 @param channelId <#channelId description#>
 @param userId <#userId description#>
 @param clientId <#clientId description#>
 @param source <#source description#>
 @return <#return value description#>
 */
+(ZYAnalyticsClientInfo*)clentInfoWithpProductId:(NSString*)productId
                                       channelId:(NSString*)channelId
                                          userId:(NSString*)userId
                                        clientId:(NSString*)clientId
                                          source:(NSString*)source;

@end
