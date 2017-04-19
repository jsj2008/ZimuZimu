//
//  ZimuAudioPlayer.m
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZimuAudioPlayer.h"

@implementation ZimuAudioPlayer

+ (instancetype)shareInstance{
    static ZimuAudioPlayer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZimuAudioPlayer alloc]init];
        [instance setupTimer];
    });
    return instance;
}

- (void)setupTimer{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
- (void)timerAction{
    if (self.state == STKAudioPlayerStatePlaying) {
        [self.zimuDelegate timerFiring:self.duration progress:self.progress];
    }
}
- (void)runTimerState:(BOOL)state{
    if (!state) {
        [_timer setFireDate:[NSDate distantFuture]];
    }else{
        [_timer setFireDate:[NSDate date]];
    }
//    [self.zimuDelegate timerFiring:self.duration progress:self.progress];
}

- (void)timerRestart{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self setupTimer];
}

@end
