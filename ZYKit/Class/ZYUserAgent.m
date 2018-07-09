//
//  ZYUserAgent.m
//  ZYKit
//
//  Created by 何伟东 on 2018/7/9.
//  Copyright © 2018年 章鱼彩票. All rights reserved.
//

#import "ZYUserAgent.h"
#import <AFNetworking/AFNetworking.h>
#import <Aspects/Aspects.h>

@implementation ZYUserAgent

+ (void)load{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    //bunldeId
    NSString *bunldeId = [infoDictionary objectForKey:@"CFBundleIdentifier"];
    NSString *company = @"ZY";
    NSString *product = @"LOTTERY";
    if ([bunldeId containsString:@"ttjj"]) {
        company = @"ZY";
        product = @"JKSC";
    }else if([bunldeId containsString:@"a8"]){
        company = @"A8";
        product = @"LOTTERY";
    }else{
        company = @"ZY";
        product = @"LOTTERY";
    }
    NSString *addtional = [NSString stringWithFormat:@"%@_%@_iOS_%@/%@",company,product,app_version,app_build];
    //修改浏览器默认useragent
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *userAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    userAgent = [NSString stringWithFormat:@"%@ %@",userAgent,addtional];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:userAgent, @"UserAgent", nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    
    [AFHTTPSessionManager aspect_hookSelector:@selector(POST:parameters:progress:success:failure:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,NSString *url,id parameters,NSProgress *uploadProgress,id success,id failure){
        AFHTTPSessionManager *sessionManager = (AFHTTPSessionManager*)aspectInfo.instance;
        NSString *userAgent = [sessionManager.requestSerializer valueForHTTPHeaderField:@"User-Agent"];
        userAgent = [NSString stringWithFormat:@"%@ %@",userAgent,addtional];
        [sessionManager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    } error:nil];
    
    [AFHTTPSessionManager aspect_hookSelector:@selector(GET:parameters:progress:success:failure:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo,NSString *url,id parameters,NSProgress *uploadProgress,id success,id failure){
        AFHTTPSessionManager *sessionManager = (AFHTTPSessionManager*)aspectInfo.instance;
        NSString *userAgent = [sessionManager.requestSerializer valueForHTTPHeaderField:@"User-Agent"];
        userAgent = [NSString stringWithFormat:@"%@ %@",userAgent,addtional];
        [sessionManager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    } error:nil];
}


@end
