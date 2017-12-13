//
//  ZYAnalyticsClientInfo.m
//  ZYKit
//
//  Created by 何伟东 on 2017/5/3.
//  Copyright © 2017年 章鱼彩票. All rights reserved.
//

#import "ZYAnalyticsClientInfo.h"
#import <UIKit/UIKit.h>
#import "sys/utsname.h"
#import "ZYAnalytics.h"
@implementation ZYAnalyticsClientInfo

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
                                          source:(NSString*)source{
    ZYAnalyticsClientInfo *clientInfo = [[ZYAnalyticsClientInfo alloc] init];
    [clientInfo setProduct:productId];
    [clientInfo setPlatform:@"01"];
    [clientInfo setOs_type:@"01"];
    [clientInfo setOs_version:[[UIDevice currentDevice] systemVersion]];
    [clientInfo setVersion_code:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];
    [clientInfo setVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    //[clientInfo setImei:<#(NSString *)#>];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    [clientInfo setDevice_code:deviceString];
    
    //[clientInfo setUser_agent:<#(NSString *)#>];
    [clientInfo setChannel:channelId];
    [clientInfo setSource:source];
    [clientInfo setMac:@"mac"];
    [clientInfo setApp_client_id:clientId];
    [clientInfo setIdfa:clientId];
    return clientInfo;
}

@end
