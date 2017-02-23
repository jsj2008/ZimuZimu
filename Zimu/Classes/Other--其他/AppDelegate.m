//
//  AppDelegate.m
//  Zimu
//
//  Created by Redpower on 2017/2/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AppDelegate.h"
#import "UMMobClick/MobClick.h"
#import "RootTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setUMMobClick];
    
    //设置BaseTabBarController为根控制器
    self.window = [[UIWindow alloc]init];
    RootTabBarController *rootTabBarController = [[RootTabBarController alloc]init];
    [self.window setRootViewController:rootTabBarController];
    [self.window makeKeyAndVisible];
    
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
