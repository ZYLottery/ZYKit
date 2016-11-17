//
//  ZYCHKeychain.h
//  ZYLottery
//
//  Created by wangyu on 16/4/28.
//  Copyright © 2016年 BangYing. All rights reserved.
//

#ifndef CHKeychain_h
#define CHKeychain_h


@interface ZYServiceCHKeychain : NSObject
+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;
@end


#endif /* CHKeychain_h */
