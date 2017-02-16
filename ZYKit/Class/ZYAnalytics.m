//
//  ZYAnalytics.m
//  ZYKit
//
//  Created by 何伟东 on 2016/11/17.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYAnalytics.h"
#import <MJExtension/MJExtension.h>
#import <WDKit/WDKit.h>

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
 初始化神策

 @param serverUrl 服务器url
 @param configureUrl 配置url
 @param debugMode debg模式
 @param clientInfo 客户端信息
 */
+(void)initSensorsAnalyticsWithServerUrl:(NSString*)serverUrl
                            configureUrl:(NSString*)configureUrl
                               debugMode:(SensorsAnalyticsDebugMode)debugMode
                              clientInfo:(ZYClientInfo*)clientInfo{
    [SensorsAnalyticsSDK sharedInstanceWithServerURL:serverUrl
                                     andConfigureURL:configureUrl
                                        andDebugMode:debugMode];
    [[ZYAnalytics sharedInstance] setClientInfo:clientInfo];
    
    // 追踪 "App 启动" 事件
    [[SensorsAnalyticsSDK sharedInstance] track:@"AppStart" withProperties:clientInfo.mj_keyValues];
    // 记录软件安装后首次打开事件
    BOOL isInstalled = [[NSUserDefaults standardUserDefaults] objectForKey:@"analytics_install"];
    if (!isInstalled) {
        [[SensorsAnalyticsSDK sharedInstance] track:@"AppInstall" withProperties:clientInfo.mj_keyValues];
        [[SensorsAnalyticsSDK sharedInstance] flush];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"analytics_install"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
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
    if ([matchId length] && [frontPageName length] && [nextPagename length]) {
        NSMutableDictionary *prop = [[NSMutableDictionary alloc]initWithDictionary:_clientInfo.mj_keyValues];
        NSArray *extends = @[@{@"name":@"match_id",@"value":matchId},@{@"name":@"src_page",@"value":frontPageName},@{@"name":@"dst_page",@"value":nextPagename}];
        [prop setObject:extends.mj_JSONString forKey:@"common_params"];
        
        [[SensorsAnalyticsSDK sharedInstance] track:@"sa10006" withProperties:prop];
    }else{
        DLog(@"sensors analytics params not all");
    }
}

/**
 页面访问退出事件

 @param pageMarker 页面类名如IndexViewController
 @param tureName 页面真实名如 首页
 @param type 进入还是离开
 */
-(void)defaultEnterWithPageMarker:(NSString*)pageMarker
                         tureName:(NSString*)tureName
                             type:(PageEventType)type{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    
    NSString *(^eventEqualTrue)(NSDictionary*,NSString*,NSString*) = ^(NSDictionary *prop,NSString *pageMarker,NSString *trueName){
        __block NSString *name = @"";
        [prop enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (pageMarker&&[pageMarker length]) {
                if ([key isEqualToString:pageMarker]) {
                    name = obj;
                    NSRange range = [name rangeOfString:@"\\[.*?\\]" options:NSRegularExpressionSearch];
                    if (range.location != NSNotFound) {
                        if (trueName&&trueName.length>0) {
                            name = [name stringByReplacingOccurrencesOfString:[name substringWithRange:range] withString:trueName];
                        }
                    }
                    *stop = YES;
                }
            }
        }];
        return name;
    };
    //暂时的返回字符创规则为
    // 1.如果plist有对应key(类名)  并且对应值中有[*****]可选字符串  并且传入trueName  将trueName将可选字符串替换 ps 资讯模块-章鱼爆料-[足球&&篮球]  trueName为足球  最后为:资讯模块-章鱼爆料-足球
    // 2.如果plist有对应key(类名)  并且对应值中有[*****]可选字符串  没有传入trueName     格式为 : plist对应值 去除"[]"  ps: 资讯模块-章鱼爆料-[足球&&篮球]  trueName为足球  最后为:资讯模块-章鱼爆料-足球&&篮球
    // 3.如果plist有对应key(类名)  并且对应值没有[*****]可选字符串  格式为 : plist对应值 去除"[]" ps 资讯模块-章鱼爆料-[足球&&篮球]  最后为:资讯模块-章鱼爆料-足球
    // 4.如果plist没有对应key(类名)  就是  trueName - 类名
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    NSDictionary *trueNameKeyValues = [NSDictionary dictionary];
    if ([_delegate respondsToSelector:@selector(controllerTrueNameKeyValues)]) {
        trueNameKeyValues = [_delegate controllerTrueNameKeyValues];
    }
    NSString *name = eventEqualTrue(trueNameKeyValues,pageMarker,tureName);
    if ([name length]) {
        [parameter setObject:name forKey:@"access_page"];
    }else{
        [parameter setObject:[NSString stringWithFormat:@"%@-%@",tureName?:@"",pageMarker?[NSString stringWithFormat:@"-%@",pageMarker]:@""] forKey:@"access_page"];
    }
    name = [name stringByReplacingOccurrencesOfString:@"[" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSString *envent = @"";
    if (type == PageEnterEvent) {
        envent = @"sa10004";
    }else if (type == PageLeaveEvent){
        envent = @"sa10005";
    }
    NSLog(@"access_page:%@",parameter[@"access_page"]);
    [[SensorsAnalyticsSDK sharedInstance] track:envent
                                 withProperties:parameter];
}



/**
 10002-普通点击事件埋点
 
 @param name 事件名称
 @param userOpenId <#userOpenId description#>
 */
-(void)clickEvent:(NSString*)name
             userOpenId:(NSString*)userOpenId {
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo.mj_keyValues];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:name forKey:@"button_name"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10002"
                                 withProperties:prop];
}


@end
