//
//  DeviceMessageModel.h
//  BFXianDemo1
//
//  Created by ray on 16/7/6.
//  Copyright © 2016年 BFXian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceMessageModel : NSObject
//获取设备型号 如iphone6S
+ (NSString *)GetCurrentDeviceModel;
//获取设备名称 如飞飞飞
+ (NSString *)GetName;
//获取设备系统名称 如ios
+ (NSString *)GetSystemName;
//获取设备系统版本 如9.3.1（不带iOS）
+ (NSString *)GetSystemVersion;
//获取设备内网Ip
+ (NSString *)GetHostIP;
//获取公网IP 有IP地址和IP地址对应的城市
+ (NSDictionary *)GetPublicIP;
//获取设备UUID
+ (NSString *)GetUUID;
//获取APP版本号，如：2.0
+ (NSString *)GetAPPVersion;
@end
