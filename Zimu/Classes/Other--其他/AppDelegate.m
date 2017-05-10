//
//  AppDelegate.m
//  Zimu
//
//  Created by Redpower on 2017/2/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AppDelegate.h"
#import "UMMobClick/MobClick.h"
#import "YTKNetworkConfig.h"
#import "HomeViewController.h"
#import "BaseNavigationController.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZimuAudioPlayer.h"

#import "JPUSHService.h"
#import "ZMPushManager.h"

#import "PLStreamingKit.h"
//#import "PLHomeViewController.h"
#import "PLMediaStreamingSession.h"

#import <SVProgressHUD/SVProgressHUD.h>
@interface AppDelegate ()

@property (nonatomic, strong)ZMPushManager *pushMgr;

@end

@implementation AppDelegate

- (void)setupRequestFilters{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://192.168.10.185:8080/portal/";//@"http://120.27.221.31/zimu_portal/";
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUMMobClick];
    [self configQNLive];
    [self setupRequestFilters];
    //初始化播放器
    [self configAudioPlayer];
    
    //设置BaseTabBarController为根控制器
    self.window = [[UIWindow alloc]init];
    self.window.backgroundColor = themeWhite;
//    RootTabBarController *rootTabBarController = [[RootTabBarController alloc]init];
//    [self.window setRootViewController:rootTabBarController];
    HomeViewController *viewController = [[HomeViewController alloc]init];
    [self.window setRootViewController:[[BaseNavigationController alloc]initWithRootViewController:viewController]];
    [self.window makeKeyAndVisible];

    //友盟消息推送
    _pushMgr  = [ZMPushManager shareInstance];
    [_pushMgr setUmessage:launchOptions];
    
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    return YES;
}

//设置友盟统计参数
- (void)setUMMobClick{
    UMConfigInstance.appKey = @"58ad5e6a75ca355b62000766";
    UMConfigInstance.channelId = @"App Store";
    //    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    [MobClick profileSignInWithPUID:@"playerID"];
    [MobClick setEncryptEnabled:YES];              //设置日志加密模式为YES
    
    [MobClick startWithConfigure:UMConfigInstance];
    
}
//
- (void)configQNLive{
    [PLStreamingEnv initEnv];
    
    [PLStreamingEnv setLogLevel:PLStreamLogLevelDebug];
    [PLStreamingEnv enableFileLogging];
    [PLMediaStreamingSession performSelector:@selector(enableRTCLogging)];
}

//初始化播放器
- (void)configAudioPlayer{
    NSError *error;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error];
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    if (!error) {
        NSLog(@"初始化成功");
    }else{
        NSLog(@"初始化失败");
    }
    //处理中断事件的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleInterreption:) name:AVAudioSessionInterruptionNotification object:[AVAudioSession sharedInstance]];
    // 监听耳机插入和拔掉通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audioRouteChangeListenerCallback:) name:AVAudioSessionRouteChangeNotification object:nil];
}


/**
 *  耳机插入、拔出事件
 */
- (void)audioRouteChangeListenerCallback:(NSNotification*)notification{
    NSDictionary *interuptionDict = notification.userInfo;
    
    NSInteger routeChangeReason = [[interuptionDict valueForKey:AVAudioSessionRouteChangeReasonKey] integerValue];
    
    switch (routeChangeReason) {
            
        case AVAudioSessionRouteChangeReasonNewDeviceAvailable:
            // 耳机插入
            break;
            
        case AVAudioSessionRouteChangeReasonOldDeviceUnavailable:{
            // 耳机拔掉
            // 拔掉耳机继续播放
            [[ZimuAudioPlayer shareInstance] pause];
        }
            break;
            
        case AVAudioSessionRouteChangeReasonCategoryChange:
            // called at start - also when other audio wants to play
            NSLog(@"AVAudioSessionRouteChangeReasonCategoryChange");
            break;
        default:break;
    }
}

- (void)handleInterreption:(NSNotification *)notification{
    NSDictionary *info = notification.userInfo;
    AVAudioSessionInterruptionType type = [info[@"AVAudioSessionInterruptionTypeKey"] integerValue];
    if (type == AVAudioSessionInterruptionTypeBegan){
        [[ZimuAudioPlayer shareInstance] pause];
    } else {
        [[ZimuAudioPlayer shareInstance] resume];
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePaused || [ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateStopped || [ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePlaying || [ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateBuffering) {
        //有音乐播放时才给后台权限
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        [self becomeFirstResponder];
        
        
        UIBackgroundTaskIdentifier bgTaskID = 0;
        bgTaskID = [AppDelegate backgroundPlayerID:bgTaskID];
        
        
        NSMutableDictionary *songInfo = [ [NSMutableDictionary alloc] init];
        
        MPMediaItemArtwork *albumArt = [ [MPMediaItemArtwork alloc] initWithImage: [UIImage imageNamed:@"course_fm_b"] ];
        
        [ songInfo setObject: @"赵小臭的翻唱电台" forKey:MPMediaItemPropertyTitle ];
        [ songInfo setObject: @"赵小臭" forKey:MPMediaItemPropertyArtist ];
        [ songInfo setObject: @"赵杯大dadadadadadadadada" forKey:MPMediaItemPropertyAlbumTitle ];
        [ songInfo setObject: albumArt forKey:MPMediaItemPropertyArtwork ];
        [ [MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:songInfo ];
        
    }else{
        [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
        [self resignFirstResponder];
    }
}

//实现一下backgroundPlayerID:这个方法:
+ (UIBackgroundTaskIdentifier)backgroundPlayerID:(UIBackgroundTaskIdentifier)backTaskId{
    //允许应用程序接收远程控制
    //[[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    //设置后台任务ID
    UIBackgroundTaskIdentifier newTaskId = UIBackgroundTaskInvalid;  //UIBackgroundTaskInvalid ： 用于初始化任务UIBackgroundTaskIdentifier
    newTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    if (newTaskId != UIBackgroundTaskInvalid && backTaskId != UIBackgroundTaskInvalid){
        [[UIApplication sharedApplication] endBackgroundTask:backTaskId];
    }
    return newTaskId;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event{
    if (event.type == UIEventTypeRemoteControl) {
        
        switch (event.subtype) {
                
            case UIEventSubtypeRemoteControlPause:
                //点击了暂停
                [[ZimuAudioPlayer shareInstance] pause];
                break;
            case UIEventSubtypeRemoteControlNextTrack:
                //点击了下一首
                break;
            case UIEventSubtypeRemoteControlPreviousTrack:
                //点击了上一首
                //此时需要更改歌曲信息
                break;
            case UIEventSubtypeRemoteControlPlay:
                //点击了播放
                [[ZimuAudioPlayer shareInstance] resume];
                break;
            case UIEventSubtypeRemoteControlTogglePlayPause:
                //耳机线控：暂停
                if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePlaying) {
                    [[ZimuAudioPlayer shareInstance] pause];
                }else if([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePaused){
                    [[ZimuAudioPlayer shareInstance] resume];
                }
                break;
            default:
                break;
        }
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    //设置应用角标为0
    application.applicationIconBadgeNumber = 0;
    //    [JPUSHService resetBadge];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
}
#pragma mark - 接收到推送，iOS 10以下
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [_pushMgr didReceiveRemoteNotificationbefore10:userInfo];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
