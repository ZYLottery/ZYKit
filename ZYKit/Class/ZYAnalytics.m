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
@property(nonatomic,strong) NSMutableDictionary *clientInfo;
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
                              clientInfo:(ZYAnalyticsClientInfo*)clientInfo{
    [SensorsAnalyticsSDK sharedInstanceWithServerURL:serverUrl andDebugMode:debugMode];
    [[SensorsAnalyticsSDK sharedInstance] identify:clientInfo.app_client_id];
    
    [[ZYAnalytics sharedInstance] setClientInfo:[clientInfo mj_keyValues]];
    
    // 追踪 "App 启动" 事件
    [[SensorsAnalyticsSDK sharedInstance] track:@"AppStart" withProperties:[clientInfo mj_keyValues]];
    // 记录软件安装后首次打开事件
    BOOL isInstalled = [[NSUserDefaults standardUserDefaults] boolForKey:@"analytics_install"];
    if (!isInstalled) {
        [[SensorsAnalyticsSDK sharedInstance] trackInstallation:@"AppInstall" withProperties:[clientInfo mj_keyValues]];
        //[[SensorsAnalyticsSDK sharedInstance] track:@"AppInstall" withProperties:[clientInfo mj_keyValues]];
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
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
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
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
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
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
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
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
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
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
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
 @param userOpenId 用户id
 */
-(void)enterPageFromEvent:(NSString*)matchId
            frontPageName:(NSString*)frontPageName
             nextPageName:(NSString*)nextPagename
               userOpenId:(NSString*)userOpenId{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    if ([matchId length] && [frontPageName length] && [nextPagename length]) {
        NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
        [prop setValue:userOpenId forKey:@"user_open_id"];
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
 @param userOpenId 用户id
 */
-(void)defaultEnterWithPageMarker:(NSString*)pageMarker
                         tureName:(NSString*)tureName
                             type:(PageEventType)type
                       userOpenId:(NSString*)userOpenId{
    
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
    NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
    [parameter setValue:userOpenId forKey:@"user_open_id"];
    NSDictionary *trueNameKeyValues = [NSDictionary dictionary];
    if ([_delegate respondsToSelector:@selector(controllerTrueNameKeyValues)]) {
        trueNameKeyValues = [_delegate controllerTrueNameKeyValues];
    }
    NSString *name = eventEqualTrue(trueNameKeyValues,pageMarker,tureName);
    if ([name length]) {
        [parameter setObject:name forKey:@"access_page"];
    }else{
        //找不到配置的对应页面，不统计
        return;
        [parameter setObject:[NSString stringWithFormat:@"%@%@",tureName?:@"",pageMarker?[NSString stringWithFormat:@"-%@",pageMarker]:@""] forKey:@"access_page"];
    }
    name = [name stringByReplacingOccurrencesOfString:@"[" withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"]" withString:@""];
    NSString *envent = @"";
    if (type == PageEnterEvent) {
        envent = @"sa10004";
    }else if (type == PageLeaveEvent){
        envent = @"sa10005";
    }
    NSLog(@"access_page:%@",parameter);
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
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:name forKey:@"button_name"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10002"
                                 withProperties:prop];
}

/**
 10002-普通点击事件埋点

 @param name 事件名称
 @param userOpenId <#userOpenId description#>
 @param itemId 定义详见：600204-天天竞猜-(iap)可兑换鱼丸列表
 */
-(void)clickEvent:(NSString*)name
       userOpenId:(NSString*)userOpenId itemId:(NSString *)itemId{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:name forKey:@"button_name"];
    [prop setValue:itemId forKey:@"itemId"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10002"
                                 withProperties:prop];
}

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
                  popWindowName:(NSString*)popWindowName{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:popWindowId forKey:@"pop_window_id"];
    [prop setValue:popWindowType forKey:@"pop_window_type"];
    [prop setValue:popWindowName forKey:@"pop_window_name"];
    [prop setValue:popWindowContentType forKey:@"pop_window_content_type"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10007"
                                 withProperties:prop];
}



/**
 弹窗按钮点击事件

 @param userOpenId 用户openId
 @param popWindowId 弹窗ID
 @param popButtonId 弹窗按钮ID
 */
-(void)alertButtonEventWithUserOpenId:(NSString*)userOpenId
                    popWindowId:(NSString*)popWindowId
                  popButtonId:(NSString*)popButtonId{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:popWindowId forKey:@"pop_window_id"];
    [prop setValue:popButtonId forKey:@"pop_button_id"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10008"
                                 withProperties:prop];
}


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
                      shareLink:(NSString*)shareLink{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:shareId forKey:@"share_id"];
    [prop setValue:shareRefer forKey:@"share_refer"];
    [prop setValue:shareOrigin forKey:@"share_origin"];
    [prop setValue:shareType forKey:@"share_type"];
    [prop setValue:shareTitle forKey:@"share_title"];
    [prop setValue:shareContent forKey:@"share_content"];
    [prop setValue:shareImage forKey:@"share_image"];
    [prop setValue:shareLink forKey:@"share_link"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10009"
                                 withProperties:prop];
}


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
                      shareLink:(NSString*)shareLink{
    NSAssert(_clientInfo, @"ZYAnalytics:client info not nil");
    NSMutableDictionary *prop = [NSMutableDictionary dictionaryWithDictionary:_clientInfo];
    [prop setValue:userOpenId forKey:@"user_open_id"];
    [prop setValue:shareId forKey:@"share_id"];
    [prop setValue:shareRefer forKey:@"share_refer"];
    [prop setValue:shareOrigin forKey:@"share_origin"];
    [prop setValue:shareType forKey:@"share_type"];
    [prop setValue:shareTitle forKey:@"share_title"];
    [prop setValue:shareContent forKey:@"share_content"];
    [prop setValue:shareImage forKey:@"share_image"];
    [prop setValue:shareLink forKey:@"share_link"];
    [[SensorsAnalyticsSDK sharedInstance] track:@"sa10010"
                                 withProperties:prop];
}

@end
