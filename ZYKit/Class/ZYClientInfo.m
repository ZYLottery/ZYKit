//
//  ZYClientInfo.m
//  ZYKit
//
//  Created by 何伟东 on 2016/11/17.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYClientInfo.h"
#import "sys/utsname.h"
#import <UIKit/UIKit.h>
#import <WDKit/WDKeyChain.h>
#import <AdSupport/AdSupport.h>
#import <SimulateIDFA/SimulateIDFA.h>
#import <MJExtension/MJExtension.h>
@implementation ZYClientInfo


/**
 *  获取idfa
 *
 *  @return <#return value description#>
 */
+ (NSString*)getIDFA{
    BOOL(^volidateIdfa)(NSString *idfa) = ^(NSString *idfa){
        if (![idfa length]||
            [[[idfa stringByReplacingOccurrencesOfString:@"0" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""] length] == 0) {
            return NO;
        }
        return YES;
    };
    
    NSString *strRet;
    // 使用钥匙链读写idfa
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *keyName = [[NSString stringWithFormat:@"%@.adfa.name",identifier]init];
    NSString *keyValue = [[NSString stringWithFormat:@"%@.adfa.value",identifier]init];
    
    NSMutableDictionary *KeyNameValue = (NSMutableDictionary *)[WDKeyChain loadWithKey:keyName];
    NSString *ValueADFA= [KeyNameValue objectForKey:keyValue];
    
    if (volidateIdfa(ValueADFA)) {
        strRet = ValueADFA;
    }else{
        NSString *idfa =[[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
        //未获取到系统idfa
        if (!volidateIdfa(idfa)) {
            //用第三方类库去取idfa
            NSString *simulateIDFA = [SimulateIDFA createSimulateIDFA];
            if (!volidateIdfa(simulateIDFA)) {
                strRet = [[NSUUID UUID] UUIDString];
            }else{
                strRet = simulateIDFA;
            }
        }else{
            strRet = idfa;
        }
        NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
        [usernamepasswordKVPairs setObject:strRet forKey:keyValue];
        [WDKeyChain saveWithKey:keyName data:usernamepasswordKVPairs];
    }
    return strRet;
}


/**
 默认clientInfo
 
 @param productId 外部变量
 @param channelId 外部变量
 @return <#return value description#>
 */
+(ZYClientInfo*)clentInfoWithpProductId:(NSString*)productId
                          channelId:(NSString*)channelId
                                 userId:(NSString*)userId{
    ZYClientInfo *clientInfo = [[ZYClientInfo alloc] init];
    [clientInfo setImei:@""];
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    //[clientInfo setDeviceCode:[[UIDevice currentDevice] model]];
    [clientInfo setDeviceCode:deviceString];
    [clientInfo setOsType:@"01"];
    [clientInfo setOsVersion:[[UIDevice currentDevice] systemVersion]];
    [clientInfo setUserAgent:@""];
    [clientInfo setPlatform:@"01"];
    [clientInfo setVersion:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [clientInfo setVersionCode:[[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"] intValue]];
    [clientInfo setSource:@"0001"];
    [clientInfo setIdfa:[ZYClientInfo getIDFA]];
    [clientInfo setScreenWidth:[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width*[UIScreen mainScreen].scale]];
    [clientInfo setScreenHeight:[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.height*[UIScreen mainScreen].scale]];
    [clientInfo setProduct:productId];
    [clientInfo setChannel:channelId];
    [clientInfo setUserOpenId:userId];
    return clientInfo;
}

@end
