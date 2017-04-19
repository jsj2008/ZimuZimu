//
//  UMessageManager.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "UMessageManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZimuAudioPlayer.h"

static SystemSoundID shake_sound_male_id = 283;
@interface UMessageManager ()<UNUserNotificationCenterDelegate>

@end

@implementation UMessageManager
+ (instancetype)shareInstance{
    static UMessageManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[UMessageManager alloc]init];
    });
    return instance;
}

- (void)setUmessage:(NSDictionary *)launchOptions{
    [UMessage startWithAppkey:@"58f5940a8f4a9d52b7002380" launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate = self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
}
#pragma mark - 接收到消息的处理
- (void)didReceiveRemoteNotificationbefore10:(NSDictionary *)userInfo{
    [UMessage didReceiveRemoteNotification:userInfo];
    
    //    self.userInfo = userInfo;
    //    //定制自定的的弹出框
    //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    //    {
    //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
    //                                                            message:@"Test On ApplicationStateActive"
    //                                                           delegate:self
    //                                                  cancelButtonTitle:@"确定"
    //                                                  otherButtonTitles:nil];
    //
    //        [alertView show];
    //
    //    }
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //收到推送的请求
        UNNotificationRequest *request = notification.request;
        
        //收到推送的内容
        UNNotificationContent *content = request.content;
        
        //收到用户的基本信息
        NSDictionary *userInfo = content.userInfo;
        
        //收到推送消息的角标
        NSNumber *badge = content.badge;
        
        //收到推送消息body
        NSString *body = content.body;
        
        //推送消息的声音
        UNNotificationSound *sound = content.sound;
        
        // 推送消息的副标题
        NSString *subtitle = content.subtitle;
        
        // 推送消息的标题
        NSString *title = content.title;

        
        //远程通知
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];

        
    }else{
        //本地通知
        //应用处于前台时的本地推送接受

    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //远程推送
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        

    }else{
    
    }
    
}
- (void)playMusic{
    [[ZimuAudioPlayer shareInstance] playURL:[NSURL fileURLWithPath:@"my.caf" isDirectory:YES]];
}
#pragma mark - 别名相关
- (void)setAlias:(NSString *)aliasName type:(NSString *)aliasType{
    [UMessage setAlias:aliasName type:aliasType response:^(id responseObject, NSError *error) {
        
    }];
}
- (void)removeAlias:(NSString *)aliasName type:(NSString *)aliasType{
    [UMessage removeAlias:aliasName type:aliasType response:^(id responseObject, NSError *error) {
        
    }];
}

@end
