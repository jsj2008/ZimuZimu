//
//  ClearUpCache.m
//  Zimu
//
//  Created by Redpower on 2017/5/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ClearUpCacheHelper.h"

@implementation ClearUpCacheHelper

+ (void)clearUpCache{
    NSArray *subFilePath = @[@"/Library/Caches/com.hackemist.SDWebImageCache.default/", @"/Library/Caches/Snapshots/"];
    // 内存清理
    NSString *homePath = NSHomeDirectory();
    
    for (NSString *filePath in subFilePath){
        // 获取SDWebImage的缓存文件夹路径
        NSString *subFile = [homePath stringByAppendingPathComponent:filePath];
        // 创建一个文件管理器  单例
        NSFileManager *fileManager = [NSFileManager defaultManager]; // 文件管理器
        // 获取某个路径下所有文件的文件名
        NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:subFile error:nil];
        // 遍历文件夹
        for (NSString *fileName in fileNames){
            // 拼接文件路径
            NSString *file = [subFile stringByAppendingPathComponent:fileName];
            // 删除文件
            [fileManager removeItemAtPath:file error:nil];
        }
    }
}

//计算文件大小
+ (long long)countFileSize {
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@", homePath);
    NSArray *subFilePath = @[@"/Library/Caches/com.hackemist.SDWebImageCache.default/", @"/Library/Caches/Snapshots/"];
    
    long long fileSize = 0;
    
    for (NSString *filePath in subFilePath) {
        NSString *subFile = [homePath stringByAppendingPathComponent:filePath];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *fileNames = [fileManager subpathsOfDirectoryAtPath:subFile error:nil];
        
        for (NSString *fileName in fileNames) {
            NSString *file = [subFile stringByAppendingPathComponent:fileName];
            NSDictionary *dic = [fileManager attributesOfItemAtPath:file error:nil];
            fileSize += [dic[NSFileSize] longLongValue];
        }
    }
//    _fileSizeLabel.text = [NSString stringWithFormat:@"%.2fMB", (CGFloat)fileSize / 1024 / 1024];
    if (fileSize == 0) {
        
    }
    return fileSize;
}

@end
