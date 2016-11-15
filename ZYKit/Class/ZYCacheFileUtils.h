//
//  ZYCacheFileUtils.h
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/24.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYCacheFileUtils : NSObject

/**
 界面归档缓存  此缓存下的文件清理后不影响使用 可以从服务器再取

 @param objc 归档对象
 @param fileName 文件名   文件夹为默认文件夹
 @param userId 用户id,可以不传则为通用
 */
+ (void)archiveListObject:(id)objc
                 pathName:(NSString *)fileName
                   userId:(NSString*)userId;

+ (instancetype)unarchivedListObjectwithFilePathName:(NSString *)fileName
                                              userId:(NSString*)userId;

/**
 删除归档

 @param fileName 文件名   文件夹为默认文件夹
 @param userId 用户id,可以不传则为通用
 @return <#return value description#>
 */
+ (BOOL)deleteListObjectwithFilePathName:(NSString *)fileName
                                  userId:(NSString*)userId;
/**
 *  界面缓存文件夹地址
 */
+ (NSString *)cacheListPath;
+ (NSString *)cacheListPathwithFilename:(NSString *)fileName;

/**
 *  归档
 *  @param objc 对象（模型或者NSArray等）
 *  @param path 地址
 *  @return ··········
 */
+ (BOOL)archiveModalObject:(id)objc withFilePath:(NSString *)path;

/**
 *  解档
 *  @param path 地址
 *  @return ··········
 */
+ (instancetype)unarchivedModalObjectwithPath:(NSString *)path;






@end
