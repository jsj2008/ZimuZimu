//
//  ZMPushManager.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "JPUSHService.h"
#import <UserNotifications/UserNotifications.h>


@interface ZMPushManager : NSObject
//获取mgr单例
+ (instancetype)shareInstance;


//设置友盟推送账号信息
- (void)setUmessage:(NSDictionary *)launchOptions;
//接收到通知 ios 10以下
- (void)didReceiveRemoteNotificationbefore10:(NSDictionary *)userInfo;

//别名相关
//- (void)setAlias:(NSString *)aliasName type:(NSString *)aliasType;
//- (void)removeAlias:(NSString *)aliasName type:(NSString *)aliasType;

@end

