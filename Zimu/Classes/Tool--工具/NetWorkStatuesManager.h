//
//  NetWorkStatuesManager.h
//  Zimu
//
//  Created by apple on 2017/3/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AppRechabilityDelegate <NSObject>

/** 连接到wifi **/
- (void)connectToWIFI;
/** 失去网络连接 **/
- (void)lostConnect;
/** 连接到移动4G/3G网络 **/
- (void)connectToWan;

@end

@interface NetWorkStatuesManager : NSObject

@property (nonatomic, weak) id<AppRechabilityDelegate> appRechabilituDelegate;
//单例
+ (NetWorkStatuesManager *)shareInstance;

@end
