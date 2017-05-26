//
//  ZimuRefreshGifHeader.m
//  Zimu
//
//  Created by Redpower on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZimuRefreshGifHeader.h"

@implementation ZimuRefreshGifHeader


- (void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
//    for (NSUInteger i = 1; i<=60; i++) {
//    }
    NSMutableArray *idleImages = [NSMutableArray array];
    UIImage *image = [UIImage imageNamed:@"refresh_1"];
    [idleImages addObject:image];
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=7; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];

    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
}

@end
