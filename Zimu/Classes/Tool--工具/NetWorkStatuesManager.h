//
//  NetWorkStatuesManager.h
//  Zimu
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

//每个cell的不同状态
typedef NS_ENUM(NSInteger, ZMNetState) {
     ZMNetStateWIFI = 0,              // wifi
    ZMNetStateWan = 1,                // 移动蜂窝网络
    ZMNetStateLost = 2,                //失去连接
    ZMNetStateDefault = 3               //初始状态
};
@protocol AppRechabilityDelegate <NSObject>

/** 连接到wifi **/
- (void)connectToWIFI;
/** 失去网络连接 **/
- (void)lostConnect;
/** 连接到移动4G/3G网络 **/
- (void)connectToWan;

@end

@interface NetWorkStatuesManager : NSObject

@property (nonatomic, assign) ZMNetState netState;

@property (nonatomic, weak) id<AppRechabilityDelegate> appRechabilituDelegate;
//单例
+ (NetWorkStatuesManager *)shareInstance;


@end
