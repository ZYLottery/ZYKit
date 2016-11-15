//
//  ZYCacheFileUtils.m
//  ZYLottery
//
//  Created by guanxuhang1234 on 16/6/24.
//  Copyright © 2016年 章鱼彩票. All rights reserved.
//

#import "ZYCacheFileUtils.h"
#import <WDKit/WDKit.h>

@implementation ZYCacheFileUtils

+ (void)archiveListObject:(id)objc
         pathName:(NSString *)fileName
                   userId:(NSString*)userId{
    NSString * realfileName = fileName;
    NSString * path = realfileName = [NSString stringWithFormat:@"%@_%@",userId?:@"",fileName];
    path = [self cacheListPathwithFilename:realfileName];
    [NSKeyedArchiver archiveRootObject:objc toFile:path];
}

+ (instancetype)unarchivedListObjectwithFilePathName:(NSString *)fileName
                                              userId:(NSString*)userId{
    NSString * realfileName = fileName;
    NSString * path = realfileName = [NSString stringWithFormat:@"%@_%@",userId?:@"",fileName];
     path = [self cacheListPathwithFilename:realfileName];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

+ (BOOL)deleteListObjectwithFilePathName:(NSString *)fileName
                                  userId:(NSString*)userId{
    NSString * realfileName = fileName;
    NSString * path = realfileName = [NSString stringWithFormat:@"%@_%@",userId?:@"",fileName];;
    path = [self cacheListPathwithFilename:realfileName];
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

/**
 *  界面缓存
 *
 *  @return <#return value description#>
 */
+ (NSString *)cacheListPath{
    NSString * removeCache = [self canRemovePath];
    NSString * path = [removeCache stringByAppendingPathComponent:@"ListDataChe_cache"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    return path;
}

/**
 *  可以随时删除的缓存数据  不是很重要
 *
 *  @return <#return value description#>
 */
+ (NSString *)canRemovePath{
    NSString * documentPath = DOCUMENT_PATH;
    NSString * path = [documentPath stringByAppendingPathComponent:@"canRemove_cache"];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:path]){
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:TRUE attributes:nil error:nil];
    }
    return path;
}
+ (NSString *)cacheListPathwithFilename:(NSString *)fileName{
    return [[self cacheListPath] stringByAppendingPathComponent:fileName];
}

+(BOOL)archiveModalObject:(id)objc withFilePath:(NSString *)path{
    return [NSKeyedArchiver archiveRootObject:objc toFile:path];
}

+(instancetype)unarchivedModalObjectwithPath:(NSString *)path{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
@end
