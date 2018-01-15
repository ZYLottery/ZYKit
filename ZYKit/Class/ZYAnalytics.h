//
//  ZYAnalytics.h
//  ZYKit
//
//  Created by 何伟东 on 2016/11/17.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#import "ZYAnalyticsClientInfo.h"

typedef enum : NSUInteger {
    PageEnterEvent,
    PageLeaveEvent,
} PageEventType;


@protocol ZYAnalyticsDelegate <NSObject>
@required;
-(NSDictionary*)controllerTrueNameKeyValues;
@end
@interface ZYAnalytics : NSObject
@property(nonatomic,strong)NSString *environment;

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
                              clientInfo:(ZYAnalyticsClientInfo*)clientInfo;


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
 @param userOpenId 用户id
 */
-(void)enterPageFromEvent:(NSString*)matchId
            frontPageName:(NSString*)frontPageName
             nextPageName:(NSString*)nextPagename
               userOpenId:(NSString*)userOpenId;


/**
 页面访问退出事件
 
 @param pageMarker 页面类名如IndexViewController
 @param tureName 页面真实名如 首页
 @param type 进入还是离开
 @param userOpenId 用户id
 */
-(void)defaultEnterWithPageMarker:(NSString*)pageMarker
                         tureName:(NSString*)tureName
                             type:(PageEventType)type
                       userOpenId:(NSString*)userOpenId;

/**
 10002-普通点击事件埋点
 
 @param name 事件名称
 @param userOpenId <#userOpenId description#>
 */
-(void)clickEvent:(NSString*)name
       userOpenId:(NSString*)userOpenId;

/**
 10002-普通点击事件埋点
 
 @param name 事件名称
 @param userOpenId <#userOpenId description#>
 @param itemId 定义详见：600204-天天竞猜-(iap)可兑换鱼丸列表
 */
-(void)clickEvent:(NSString*)name
       userOpenId:(NSString*)userOpenId itemId:(NSString *)itemId;

/**
 弹窗展示事件
 
 @param userOpenId 用户openId
 @param popWindowId 弹窗ID
 @param popWindowType 弹窗类型
 @param popWindowContentType 弹窗内容类型，0-业务成功弹窗 1-业务失败弹窗
 @param popWindowName 弹窗名字 两者至少存在一个 本地逻辑触发的弹窗时有效
 */
-(void)alertEventWithUserOpenId:(NSString*)userOpenId
                    popWindowId:(NSString*)popWindowId
                  popWindowType:(NSString*)popWindowType
           popWindowContentType:(NSString*)popWindowContentType
                  popWindowName:(NSString*)popWindowName;


/**
 弹窗按钮点击事件
 
 @param userOpenId 用户openId
 @param popWindowId 弹窗ID
 @param popButtonId 弹窗按钮ID
 */
-(void)alertButtonEventWithUserOpenId:(NSString*)userOpenId
                          popWindowId:(NSString*)popWindowId
                          popButtonId:(NSString*)popButtonId;

/**
 分享触发事件
 
 @param userOpenId 用户openId
 @param shareId 分享唯一ID 客户端本地时间戳，微妙级别
 @param shareRefer 分享来源
 @param shareOrigin 分享信息方式 0-本地截屏分享 1-使用服务器提供的参数分享
 @param shareType 分享平台类型 0-微信好友 1-微信朋友圈 2-QQ好友 3-QQ空间 4-新浪微博
 @param shareTitle 分享标题
 @param shareContent 分享内容
 @param shareImage 分享图片链接
 @param shareLink 分享链接
 */
-(void)shareEventWithUserOpenId:(NSString*)userOpenId
                        shareId:(NSString*)shareId
                     shareRefer:(NSString*)shareRefer
                    shareOrigin:(NSString*)shareOrigin
                      shareType:(NSString*)shareType
                     shareTitle:(NSString*)shareTitle
                   shareContent:(NSString*)shareContent
                     shareImage:(NSString*)shareImage
                      shareLink:(NSString*)shareLink;


/**
 分享成功事件
 
 @param userOpenId 用户openId
 @param shareId 分享唯一ID 客户端本地时间戳，微妙级别
 @param shareRefer 分享来源
 @param shareOrigin 分享信息方式 0-本地截屏分享 1-使用服务器提供的参数分享
 @param shareType 分享平台类型 0-微信好友 1-微信朋友圈 2-QQ好友 3-QQ空间 4-新浪微博
 @param shareTitle 分享标题
 @param shareContent 分享内容
 @param shareImage 分享图片链接
 @param shareLink 分享链接
 */
-(void)shareSuccessEventWithUserOpenId:(NSString*)userOpenId
                               shareId:(NSString*)shareId
                            shareRefer:(NSString*)shareRefer
                           shareOrigin:(NSString*)shareOrigin
                             shareType:(NSString*)shareType
                            shareTitle:(NSString*)shareTitle
                          shareContent:(NSString*)shareContent
                            shareImage:(NSString*)shareImage
                             shareLink:(NSString*)shareLink;

@end
