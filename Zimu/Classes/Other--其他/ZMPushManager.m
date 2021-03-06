//
//  ZMPushManager.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZMPushManager.h"
#import <AdSupport/AdSupport.h>
#import "FriendsMsgViewController.h"
#import "ZM_CallingHandleCategory.h"

@interface ZMPushManager ()<UNUserNotificationCenterDelegate, JPUSHRegisterDelegate>

@end

@implementation ZMPushManager
+ (instancetype)shareInstance{
    static ZMPushManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZMPushManager alloc]init];
        
    });
    return instance;
}

- (void)setUmessage:(NSDictionary *)launchOptions{
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    
    // Optional
    // 获取IDFA
    // 如需使用IDFA功能请添加此代码并在初始化方法的advertisingIdentifier参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
//     Required
//     init Push
//     notice: 2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil
//     如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"80986c5285f33ec53970d4d6"
                          channel:@"App Store"
                 apsForProduction:0
            advertisingIdentifier:advertisingId];
    
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    //iOS10必须加下面这段代码。
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
        [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                //点击允许
                //这里可以添加一些自己的逻辑
                NSLog(@"12348");
            } else {
                NSLog(@"8575");
                //点击不允许
                //这里可以添加一些自己的逻辑
            }
        }];
    }
    //打开日志，方便调试
    [JPUSHService setLogOFF];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
}
- (void)serAliasSel{
    NSLog(@"1235");
}
- (void)networkDidReceiveMessage:(NSNotification *)notification{
    NSLog(@"%@", notification.userInfo);
}

#pragma mark - 接收到消息的处理
- (void)didReceiveRemoteNotificationbefore10:(NSDictionary *)userInfo{
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
//    completionHandler(UIBackgroundFetchResultNewData);
//    [UMessage didReceiveRemoteNotification:userInfo];
    
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
//
////iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSDictionary * userInfo = notification.request.content.userInfo;
    //前台收到推送，远程
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
//        [UMessage setAutoAlert:NO];
        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
        NSLog(@"%@", userInfo);
         NSLog(@"收到推送33");
        if ([userInfo[@"type"] integerValue] == 1) { //如果是添加好友
            FriendsMsgViewController *msgVC = [[FriendsMsgViewController alloc] init];
            UIViewController *curVC = [ZM_CallingHandleCategory curTopViewController];
//            [curVC presentViewController:msgVC animated:YES completion:nil];
            [curVC.navigationController pushViewController:msgVC animated:YES];
        }
        if ([userInfo[@"type"] integerValue] == 2) { //如果是视频通话请求
            ZM_CallingHandleCategory *call = [ZM_CallingHandleCategory shareInstance];
            call.roomName = userInfo[@"roomName"];
            call.role = ([userInfo[@"num"] integerValue] == 2) ? ZMChatRoleSingleViewer:ZMChatRoleGroupViewers;
            [ZM_CallingHandleCategory jumpToWaitVC];
        }
        completionHandler(UNNotificationPresentationOptionAlert);
    }else{//本地推送，前台
        //本地通知
         NSLog(@"收到推送44");
        //应用处于前台时的本地推送接受
        completionHandler(UNNotificationPresentationOptionAlert);
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    //远程推送，点击
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
        NSLog(@"收到推送11");
        if ([userInfo[@"type"] integerValue] == 1) { //如果是添加好友
            FriendsMsgViewController *msgVC = [[FriendsMsgViewController alloc] init];
            UIViewController *curVC = [ZM_CallingHandleCategory curTopViewController];
            [curVC presentViewController:msgVC animated:YES completion:nil];
        }
        if ([userInfo[@"type"] integerValue] == 2) { //如果是视频通话请求
            ZM_CallingHandleCategory *call = [ZM_CallingHandleCategory shareInstance];
            call.roomName = userInfo[@"roomName"];
            call.role = ([userInfo[@"num"] integerValue] == 2) ? ZMChatRoleSingleViewer:ZMChatRoleGroupViewers;
            [ZM_CallingHandleCategory jumpToWaitVC];
        }
         NSLog(@"%@", userInfo);
    }else{  //本地推送点击
         NSLog(@"收到推送22");
    }
    
}
//- (void)playMusic{
//    [[ZimuAudioPlayer shareInstance] playURL:[NSURL fileURLWithPath:@"my.caf" isDirectory:YES]];
//}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"推送收到  1");
    }else{
        
        NSLog(@"推送收到  4");
    }
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) { //
        NSLog(@"推送收到  2");
    }else{
        
        NSLog(@"推送收到  5");
    }
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    NSLog(@"推送收到  3");
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData | UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}



//#pragma mark - 别名相关
//- (void)setAlias:(NSString *)aliasName type:(NSString *)aliasType{
//    [UMessage setAlias:aliasName type:aliasType response:^(id responseObject, NSError *error) {
//
//    }];
//}
//- (void)removeAlias:(NSString *)aliasName type:(NSString *)aliasType{
//    [UMessage removeAlias:aliasName type:aliasType response:^(id responseObject, NSError *error) {
//
//    }];
//}
@end
