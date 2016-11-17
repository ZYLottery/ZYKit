//
//  ZYAnalytics.m
//  ZYKit
//
//  Created by 何伟东 on 2016/11/17.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYAnalytics.h"
#import <SensorsAnalyticsSDK/SensorsAnalyticsSDK.h>
#import <MJExtension/MJExtension.h>

@interface ZYAnalytics(){
    
}
@property(nonatomic,strong) ZYClientInfo *clientInfo;
@end

@implementation ZYAnalytics

static id sharedInstance = NULL;

+ (ZYAnalytics *)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance  = [[ZYAnalytics alloc] init];
    });
    return sharedInstance;
}

/**
 初始化客户端信息
 
 @param clientInfo <#clientInfo description#>
 */
+(void)initWithClientInfo:(ZYClientInfo*)clientInfo{
    [[ZYAnalytics sharedInstance] setClientInfo:clientInfo];
}

/**
 10001-首页banner展示事件

 @param bunnerId <#bunnerId description#>
 @param url <#url description#>
 @param userOpenId <#userOpenId description#>
 */
-(void)bunnerShowEvent:(NSString*)bunnerId
             bannerUrl:(NSString*)url
            userOpenId:(NSString*)userOpenId {
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:bunnerId forKey:@"banner_id"];
    [prop setValue:url forKey:@"banner_url"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10001"
                                 withProperties:prop];
}

/**
 10002-首页banner点击事件

 @param bunnerId <#bunnerId description#>
 @param url <#url description#>
 @param userOpenId <#userOpenId description#>
 */
-(void)bunnerClickEvent:(NSString*)bunnerId
             bannerUrl:(NSString*)url
            userOpenId:(NSString*)userOpenId {
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:bunnerId forKey:@"banner_id"];
    [prop setValue:url forKey:@"banner_url"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10002"
                                 withProperties:prop];
}


/**
 10003-爆料点击事件

 @param userOpenId <#userOpenId description#>
 @param matchId <#matchId description#>
 */
-(void)brokeNewsEvent:(NSString*)userOpenId
              matchId:(NSString*)matchId{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:matchId forKey:@"match_id"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10003"
                                 withProperties:prop];
}

/**
 10004-页面访问事件

 @param userOpenId <#userOpenId description#>
 @param pageName <#pageName description#>
 */
-(void)pageViewEvent:(NSString*)userOpenId
            pageName:(NSString*)pageName{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:pageName forKey:@"access_page"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10004"
                                 withProperties:prop];
}


/**
 10005-页面退出事件

 @param userOpenId <#userOpenId description#>
 @param pageName <#pageName description#>
 */
-(void)pageQuitEvent:(NSString*)userOpenId
            pageName:(NSString*)pageName{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:pageName forKey:@"access_page"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10005"
                                 withProperties:prop];
}

/**
 10006-页面跳转事件
 
 @param matchId 赛事id
 @param frontPageName 当前界面名
 @param nextPagename 下一界面名
 */
-(void)enterPageFromEvent:(NSString*)matchId
            frontPageName:(NSString*)frontPageName
             nextPageName:(NSString*)nextPagename{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    NSMutableDictionary *common_params = [NSMutableDictionary dictionary];
    [common_params setValue:matchId forKey:@"match_id"];
    [common_params setValue:frontPageName forKey:@"src_page"];
    [common_params setValue:nextPagename forKey:@"dst_page"];
    [prop setObject:common_params forKey:@"common_params"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10006"
                                 withProperties:prop];
    
}

@end
