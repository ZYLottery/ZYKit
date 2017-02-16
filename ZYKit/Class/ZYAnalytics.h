//
//  ZYAnalytics.h
//  ZYKit
//
//  Created by 何伟东 on 2016/11/17.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#import "ZYClientInfo.h"

typedef enum : NSUInteger {
    PageEnterEvent,
    PageLeaveEvent,
} PageEventType;


@protocol ZYAnalyticsDelegate <NSObject>
@required;
-(NSDictionary*)controllerTrueNameKeyValues;

@end
@interface ZYAnalytics : NSObject

@property(nonatomic,assign) id<ZYAnalyticsDelegate> delegate;
+ (ZYAnalytics *)sharedInstance;

/**
 初始化神策
 
 @param serverUrl 服务器url
 @param configureUrl 配置url
 @param debugMode debg模式
 @param clientInfo 客户端信息
 */
+(void)initSensorsAnalyticsWithServerUrl:(NSString*)serverUrl
                            configureUrl:(NSString*)configureUrl
                               debugMode:(SensorsAnalyticsDebugMode)debugMode
                              clientInfo:(ZYClientInfo*)clientInfo;


/**
 10001-首页banner展示事件
 
 @param bunnerId <#bunnerId description#>
 @param url <#url description#>
 @param userOpenId <#userOpenId description#>
 */
-(void)bunnerShowEvent:(NSString*)bunnerId
             bannerUrl:(NSString*)url
            userOpenId:(NSString*)userOpenId;

/**
 10002-首页banner点击事件
 
 @param bunnerId <#bunnerId description#>
 @param url <#url description#>
 @param userOpenId <#userOpenId description#>
 */
-(void)bunnerClickEvent:(NSString*)bunnerId
              bannerUrl:(NSString*)url
             userOpenId:(NSString*)userOpenId;

/**
 10003-爆料点击事件
 
 @param userOpenId <#userOpenId description#>
 @param matchId <#matchId description#>
 */
-(void)brokeNewsEvent:(NSString*)userOpenId
                    matchId:(NSString*)matchId;

/**
 10004-页面访问事件
 
 @param userOpenId <#userOpenId description#>
 @param pageName <#pageName description#>
 */
-(void)pageViewEvent:(NSString*)userOpenId
            pageName:(NSString*)pageName;

/**
 10005-页面退出事件
 
 @param userOpenId <#userOpenId description#>
 @param pageName <#pageName description#>
 */
-(void)pageQuitEvent:(NSString*)userOpenId
            pageName:(NSString*)pageName;

/**
 10006-页面跳转事件
 
 @param matchId 赛事id
 @param frontPageName 当前界面名
 @param nextPagename 下一界面名
 */
-(void)enterPageFromEvent:(NSString*)matchId
            frontPageName:(NSString*)frontPageName
             nextPageName:(NSString*)nextPagename;



/**
 页面访问退出事件
 
 @param pageMarker 页面类名如IndexViewController
 @param tureName 页面真实名如 首页
 @param type 进入还是离开
 */
-(void)defaultEnterWithPageMarker:(NSString*)pageMarker
                         tureName:(NSString*)tureName
                             type:(PageEventType)type;

/**
 10002-普通点击事件埋点
 
 @param name 事件名称
 @param userOpenId <#userOpenId description#>
 */
-(void)clickEvent:(NSString*)name
       userOpenId:(NSString*)userOpenId;

@end
