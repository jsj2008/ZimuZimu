//
//  ZimuAudioPlayer.h
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "STKAudioPlayer.h"

@protocol ZimuAudioPlayerDelegate <NSObject>

- (void)timerFiring:(CGFloat)duration progress:(CGFloat)progress;


@end

@interface ZimuAudioPlayer : STKAudioPlayer

@property (nonatomic, strong) NSTimer* timer;
@property (nonatomic, weak) id<ZimuAudioPlayerDelegate> zimuDelegate;

+ (instancetype)shareInstance;

- (void)runTimerState:(BOOL)state;

- (void)timerRestart;

@end
