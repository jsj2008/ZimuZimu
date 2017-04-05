//
//  FMPlayView.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMPlayView.h"
#import "CircleView.h"
#import "ZimuAudioPlayer.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SampleQueueId.h"
#import <AVFoundation/AVFoundation.h>

@interface FMPlayView ()<STKAudioPlayerDelegate, ZimuAudioPlayerDelegate>

@property (nonatomic, strong) CircleView *circleView;           //播放进度
@property (nonatomic, strong) UILabel *titleLabel;              //标题
@property (nonatomic, strong) UILabel *progressLabel;           //播放时间label
@property (nonatomic, strong) UILabel *authorLabel;             //上传者

@property (nonatomic, strong) UIButton *lastButton;             //上一曲
@property (nonatomic, strong) UIButton *nextButton;             //下一曲
@property (nonatomic, strong) UIButton *startButton;            //开始、暂停

@property (nonatomic, assign) CGFloat progressPercent;
@property (nonatomic, assign) NSNumber *duration;
@property (nonatomic, assign) NSNumber *nowDuration;

@end

@implementation FMPlayView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [ZimuAudioPlayer shareInstance].delegate = self;
        [ZimuAudioPlayer shareInstance].zimuDelegate = self;
        
        [self initAudioPlayer];
        [self setSubviews];
    }
    return self;
}

- (void)initAudioPlayer{
    if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateStopped || [ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateReady) {
        NSURL *url = [NSURL URLWithString:@"http://mxd.766.com/sdo/music/data/3/m10.mp3"];
        STKDataSource *dataSource = [STKAudioPlayer dataSourceFromURL:url];
        [[ZimuAudioPlayer shareInstance] setDataSource:dataSource withQueueItemId:[[SampleQueueId alloc] initWithUrl:url andCount:0]];
    }else if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePaused){
        [[ZimuAudioPlayer shareInstance] resume];
    }
}

- (void)timerFiring:(CGFloat)duration progress:(CGFloat)progress{
    _progressLabel.text = [NSString stringWithFormat:@"%02i:%02i / %02i:%02i",((int)progress)/60, ((int)progress)%60,((int)duration)/60, ((int)duration)%60];
    _progressPercent = (CGFloat)progress / duration;
    _circleView.progress = _progressPercent;
}


- (void)setSubviews{
    //播放进度、FM图片
    CGFloat circleViewWidth = 218 / 375.0 * kScreenWidth;
    CGFloat circleX = (self.width - circleViewWidth)/2.0;
    CGFloat circleY = 23/375.0 * kScreenWidth;
    _circleView = [[CircleView alloc]initWithFrame:CGRectMake(circleX, circleY, circleViewWidth, circleViewWidth)];
    [self addSubview:_circleView];
    
    //FM标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(_circleView.frame) + 25/375.0 * kScreenWidth, kScreenWidth - 50, 15)];
    _titleLabel.text = @"如何让爸爸妈妈们了解孩子的成长";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor colorWithHexString:@"000000"];
    [self addSubview:_titleLabel];
    
    //播放时间文字进度
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(_titleLabel.frame) + 8, self.width - 50, 15)];
    _progressLabel.font = [UIFont systemFontOfSize:14];
    _progressLabel.textColor = [UIColor colorWithHexString:@"BCBCBC"];
    _progressLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_progressLabel];
    
    //上传者
    NSString *authorString = @"上传：吴老师";
    CGSize authorSize = [authorString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat authorWith = authorSize.width + 10;
    CGFloat authorHeight = authorSize.height + 10;
    _authorLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.width - authorWith)/2.0, CGRectGetMaxY(_progressLabel.frame) + 15, authorWith, authorHeight)];
    _authorLabel.text = authorString;
    _authorLabel.font = [UIFont systemFontOfSize:14];
    _authorLabel.textColor = themeWhite;
    _authorLabel.backgroundColor = themeYellow;
    _authorLabel.textAlignment = NSTextAlignmentCenter;
    _authorLabel.layer.cornerRadius = authorHeight/2.0;
    _authorLabel.layer.masksToBounds = YES;
    [self addSubview:_authorLabel];
    
    //开始、暂停按钮
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startButton setBackgroundImage:[UIImage imageNamed:@"FM_play"] forState:UIControlStateNormal];
    [_startButton setBackgroundImage:[UIImage imageNamed:@"FM_pause"] forState:UIControlStateSelected];
    _startButton.size = _startButton.currentBackgroundImage.size;
    _startButton.center = _circleView.center;
    _startButton.selected = YES;
    [self addSubview:_startButton];

    [[_startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (!_startButton.selected) {
            //正在播放状态
            NSLog(@"state : %li",[ZimuAudioPlayer shareInstance].state);
            if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateStopped ) {
                NSURL *url = [NSURL URLWithString:@"http://mxd.766.com/sdo/music/data/3/m10.mp3"];
                STKDataSource *dataSource = [STKAudioPlayer dataSourceFromURL:url];
                [[ZimuAudioPlayer shareInstance] setDataSource:dataSource withQueueItemId:[[SampleQueueId alloc] initWithUrl:url andCount:0]];
            }else if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePaused){
                [[ZimuAudioPlayer shareInstance] resume];
            }
            
        }else{
            //暂停状态
            if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePlaying){
                [[ZimuAudioPlayer shareInstance] pause];
            }
        }
    }];
    
    //上一曲
    _lastButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_lastButton setBackgroundImage:[UIImage imageNamed:@"FM_last"] forState:UIControlStateNormal];
    _lastButton.size = _lastButton.currentBackgroundImage.size;
    CGFloat gap = 25/375.0 * kScreenWidth;
    _lastButton.center = CGPointMake(gap + _lastButton.width/2.0, _circleView.centerY);
    [self addSubview:_lastButton];
    
    [[_lastButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"快退15秒");
        double currentTime = [ZimuAudioPlayer shareInstance].progress;
        double targetTime = currentTime - 15;
        if (targetTime <= 0) {
            targetTime = 0;
        }
        [[ZimuAudioPlayer shareInstance] seekToTime:targetTime];
    }];
    
    //下一曲
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setBackgroundImage:[UIImage imageNamed:@"FM_next"] forState:UIControlStateNormal];
    _nextButton.size = _nextButton.currentBackgroundImage.size;
    _nextButton.center = CGPointMake(self.width - gap - _nextButton.width/2.0, _circleView.centerY);
    [self addSubview:_nextButton];
    
    [[_nextButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"快进15秒");
        double currentTime = [ZimuAudioPlayer shareInstance].progress;
        double targetTime = currentTime + 15;
        if (targetTime >= [ZimuAudioPlayer shareInstance].duration) {
            targetTime = [ZimuAudioPlayer shareInstance].duration;
        }
        [[ZimuAudioPlayer shareInstance] seekToTime:targetTime];
    }];
}

#pragma mark - STKAudioPlayerDelegate
- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didStartPlayingQueueItemId:(NSObject *)queueItemId{
    NSLog(@"开始播放");
}

- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishPlayingQueueItemId:(NSObject *)queueItemId withReason:(STKAudioPlayerStopReason)stopReason andProgress:(double)progress andDuration:(double)duration{
    [[ZimuAudioPlayer shareInstance] runTimerState:NO];
    _startButton.selected = NO;
    NSLog(@"播放完毕");
}
- (void)audioPlayer:(STKAudioPlayer *)audioPlayer stateChanged:(STKAudioPlayerState)state previousState:(STKAudioPlayerState)previousState{
    switch (state) {
        case STKAudioPlayerStatePlaying:
            NSLog(@"开始了");
            [[ZimuAudioPlayer shareInstance]runTimerState:YES];
            _startButton.selected = YES;
            break;
        case STKAudioPlayerStatePaused:
            NSLog(@"暂停了");
            [[ZimuAudioPlayer shareInstance]runTimerState:NO];
            _startButton.selected = NO;
            break;
        case STKAudioPlayerStateStopped:
            NSLog(@"停止了");
            [[ZimuAudioPlayer shareInstance]runTimerState:NO];
            _startButton.selected = NO;
        case STKAudioPlayerStateError:
            NSLog(@"出问题了");
        default:
            break;
    }
}
- (void)audioPlayer:(STKAudioPlayer *)audioPlayer didFinishBufferingSourceWithQueueItemId:(NSObject *)queueItemId{
    NSLog(@"缓存好了");
}
- (void)audioPlayer:(STKAudioPlayer *)audioPlayer unexpectedError:(STKAudioPlayerErrorCode)errorCode{
    NSLog(@"出了某些问题 %li",errorCode);
}


@end
