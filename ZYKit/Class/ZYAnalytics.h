//
//  ZYAnalytics.h
//  ZYKit
//
//  Created by 何伟东 on 2016/11/17.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYClientInfo.h"

@interface ZYAnalytics : NSObject

+ (ZYAnalytics *)sharedInstance;



/**
 初始化客户端信息
 
 @param clientInfo <#clientInfo description#>
 */
+(void)initWithClientInfo:(ZYClientInfo*)clientInfo;


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

@end
