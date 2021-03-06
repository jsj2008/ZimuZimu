//
//  NetWorkStatuesManager.m
//  Zimu
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NetWorkStatuesManager.h"
#import "Reachability.h"


@interface NetWorkStatuesManager ()

@property (nonatomic, strong)Reachability *hostReach;
@property (nonatomic, assign)BOOL isReachable;

@end

@implementation NetWorkStatuesManager

- (instancetype)init{
    self = [super init];
    if (self) {
        [self obeseverNet];
    }
    return self;
}
//单利获取对象，便于在其他地方使用，也不会重复创建观察者
+ (NetWorkStatuesManager *)shareInstance{
    static NetWorkStatuesManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NetWorkStatuesManager alloc]init];
        
    });
    return instance;
}
//监听网络
- (void)obeseverNet{
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    //网络连接上了，判断是wifi还是移动数据
    NetWorkStatuesManager __weak *weakSelf = self;
    reach.reachableBlock = ^(Reachability*reach){
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([reach currentReachabilityStatus] == ReachableViaWiFi) {
                [weakSelf connectWifi];
            } else if ([reach currentReachabilityStatus] == ReachableViaWWAN){
                [weakSelf connectWan];
            }
        });
    };
    //网络没连接上
    reach.unreachableBlock = ^(Reachability*reach)
    {
        [weakSelf lostNetConnect];
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [reach startNotifier];
}
#pragma  mark - 各种网络状态下的处理事件
/** 连接wifi **/
- (void)connectWifi{
    self.isReachable = YES;
    [self.appRechabilituDelegate connectToWIFI];
}
/** 连接移动3G/4G **/
- (void)connectWan{
    [self.appRechabilituDelegate connectToWan];
    self.isReachable = YES;
}
/** 失去网络连接 **/
- (void)lostNetConnect{
    self.isReachable = NO;
    [self.appRechabilituDelegate lostConnect];
}

@end
