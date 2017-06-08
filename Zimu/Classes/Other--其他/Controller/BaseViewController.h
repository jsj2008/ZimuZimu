//
//  BaseViewController.h
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZMNetChangeState) {
    ZMNetChangeStateWIFIToWan = 0,           // wifi转到4G
    ZMNetChangeStateWanToWIFI = 1,          // 移动蜂窝网络转到WiFi
    ZMNetChangeStateLost = 2,                //失去连接
    ZMNetChangeStateLostToWiFi = 3,         //重连至wifi
    ZMNetChangeStateLostToWan = 4,           //重连至4G
    ZMNetChangeStateDefault = 6
    
};

@interface BaseViewController : UIViewController

@property (nonatomic, assign)ZMNetChangeState netChangeState;

/*网络状态变化处理*/
//使用wifi
- (void)wifi;
//使用移动数据
- (void)mobileData;
//没有网络
- (void)lostNet;

@end
