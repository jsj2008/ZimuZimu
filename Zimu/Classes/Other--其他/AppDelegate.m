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
#import <UMSocialCore/UMSocialCore.h>

#import "PLStreamingKit.h"
//#import "PLHomeViewController.h"
#import "PLMediaStreamingSession.h"

#import <SVProgressHUD/SVProgressHUD.h>

#import "ZM_CallingHandleCategory.h"

#import "Pingpp.h"

@interface AppDelegate ()

@property (nonatomic, strong)ZMPushManager *pushMgr;

@end

@implementation AppDelegate

- (void)setupRequestFilters{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://116.62.200.235:8080/zimu_portal/";
    //正式：@"http://120.27.221.31/zimu_portal/"
    //亚欧的：@"http://192.168.10.183:8082/portal/";
    //猪的:@"http://192.168.3.10:8082/portal/";
    //线上测试服务器：@"http://116.62.200.235:8080/zimu_portal/";
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

    [self getCapture];
//    [ZM_CallingHandleCategory jumpToWaitVC];
    
    [self configUMSocial];
    return YES;
}

//调用摄像头权限
- (void)getCapture{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
    }];
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
#pragma mark - um分享
- (void)configUMSocial{
    [[UMSocialManager defaultManager] openLog:YES];
    // 打开图片水印
    //[UMSocialGlobal shareInstance].isUsingWaterMark = YES;
    [UMSocialGlobal shareInstance].isClearCacheWhenGetUserInfo = NO;
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"58f5940a8f4a9d52b7002380"];
    
    [self configUSharePlatforms];
    
//    [self confitUShareSettings];

}
- (void)configUSharePlatforms
{
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxf3b92b17e0cdf08b" appSecret:@"78dde879ce172c645034a5da011921ca" redirectURL:@"http://mobile.umeng.com/social"];
    /*
     * 设置微信朋友圈
     */
//     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxf3b92b17e0cdf08b" appSecret:@"78dde879ce172c645034a5da011921ca" redirectURL:@"http://mobile.umeng.com/social"];
    //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
    
    /* 设置分享到QQ互联的appID
     * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
     100424468.no permission of union id
     */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105934837"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    
    /* 设置新浪的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954"  appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    
//    /* 钉钉的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DingDing appKey:@"dingoalmlnohc0wggfedpk" appSecret:nil redirectURL:nil];
//    
//    /* 支付宝的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_AlipaySession appKey:@"2015111700822536" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    
//    /* 设置易信的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_YixinSession appKey:@"yx35664bdff4db42c2b7be1e29390c1a06" appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置点点虫（原来往）的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_LaiWangSession appKey:@"8112117817424282305" appSecret:@"9996ed5039e641658de7b83345fee6c9" redirectURL:@"http://mobile.umeng.com/social"];
//    
//    /* 设置领英的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Linkedin appKey:@"81t5eiem37d2sc"  appSecret:@"7dgUXPLH8kA8WHMV" redirectURL:@"https://api.linkedin.com/v1/people"];
//    
//    /* 设置Twitter的appKey和appSecret */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Twitter appKey:@"fB5tvRpna1CKK97xZUslbxiet"  appSecret:@"YcbSvseLIwZ4hZg9YmgJPP5uWzd4zr6BpBKGZhf07zzh3oj62K" redirectURL:nil];
//    
//    /* 设置Facebook的appKey和UrlString */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Facebook appKey:@"506027402887373"  appSecret:nil redirectURL:@"http://www.umeng.com/social"];
//    
//    /* 设置Pinterest的appKey */
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Pinterest appKey:@"4864546872699668063"  appSecret:nil redirectURL:nil];
//    
//    /* dropbox的appKey */
//    [[UMSocialManager defaultManager] setPlaform: UMSocialPlatformType_DropBox appKey:@"k4pn9gdwygpy4av" appSecret:@"td28zkbyb9p49xu" redirectURL:@"https://mobile.umeng.com/social"];
//    
//    /* vk的appkey */
//    [[UMSocialManager defaultManager]  setPlaform:UMSocialPlatformType_VKontakte appKey:@"5786123" appSecret:nil redirectURL:nil];
    
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

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

    //设置应用角标为0
    application.applicationIconBadgeNumber = 0;

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

    
}
#pragma mark - 接收到推送，iOS 10以下
//userInfo的数据格式
//{
//    "_j_business" = 1;                //极光的内容，没卵用
//    "_j_msgid" = 2620321121;
//    "_j_uid" = 9361759977;
//    aps =     {
//        alert =         {             //显示在提示框的内容
//            body = fasdfas;
//            subtitle = qweqwegerba;
//            title = asf;
//        };
//        badge = 1;                    //角标值
//        sound = "12718.caf";          //播放的声音，需要在本地有这个caf文件，一定是caf文件
//    };
//    friendName = ui;     //自定义消息字段
//    notiType = 1;        //自定义消息字段
//}

//{         //静默推送
//    "_j_business" = 1;
//    "_j_msgid" = 3964698298;
//    "_j_uid" = 9361759977;
//    aps =     {
//        alert = "";
//        "content-available" = 1;
//    };
//    we = 234;
//}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    [_pushMgr didReceiveRemoteNotificationbefore10:userInfo];
    
    NSLog(@"%@", userInfo);

}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSString *tag = @"asdf";
    NSSet *tags = [NSSet setWithObjects:tag, nil];
    NSString  *alias = @"yf";
    [JPUSHService setTags:tags alias:alias fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
         NSLog(@"rescode: %d\n tags: %@\nalias:%@", iResCode, iTags, iAlias);
     }];
    
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#warning \
为了能正确获得结果回调请在工程 AppDelegate 文件中调用 ｀[Pingpp handleOpenURL:url withCompletion:nil]`。\
如果该方法的第二个参数传 nil，请在在 `createPayment` 方法的 `Completion` 中处理回调结果。否则，在这里处理结果。\
如果你使用了微信分享、登录等一些看起来在这里“冲突”的模块，你可以先判断 url 的 host 来决定调用哪一方的方法。\
也可以先调用 Ping++ 的方法，如果 return 的值为 false，表示这个 url 不是支付相关的，你再调用模块的方法。
// iOS 8 及以下请用这个
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [Pingpp handleOpenURL:url withCompletion:nil];
}

// iOS 9 以上请用这个
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary *)options {
    return [Pingpp handleOpenURL:url withCompletion:nil];
}


@end
