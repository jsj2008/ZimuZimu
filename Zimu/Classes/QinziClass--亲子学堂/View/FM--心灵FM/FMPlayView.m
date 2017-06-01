//
//  FMPlayView.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMPlayView.h"
#import "ZimuAudioPlayer.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SampleQueueId.h"
#import <AVFoundation/AVFoundation.h>
#import <UIImageView+WebCache.h>
#import "UIImage+ZMExtension.h"

@interface FMPlayView ()<STKAudioPlayerDelegate, ZimuAudioPlayerDelegate>

//@property (nonatomic, strong) CircleView *circleView;           //播放进度
//@property (nonatomic, strong) UILabel *titleLabel;              //标题
//@property (nonatomic, strong) UILabel *progressLabel;           //播放时间label
//@property (nonatomic, strong) UILabel *authorLabel;             //上传者

@property (nonatomic, strong) UIImageView *bgImageView;     //FM背景图
@property (nonatomic, strong) UISlider *slider;             //播放进度
@property (nonatomic, strong) UILabel *totalTimeLabel;      //总时长label
@property (nonatomic, strong) UILabel *progressLabel;       //时间进度label
@property (nonatomic, strong) UIButton *startButton;        //播放按钮
@property (nonatomic, strong) UIButton *backWardButton;     //后退15秒
@property (nonatomic, strong) UIButton *forwardButton;      //前进15秒

@property (nonatomic, assign) CGFloat progressPercent;
@property (nonatomic, assign) NSNumber *duration;
@property (nonatomic, assign) NSNumber *nowDuration;

@property (nonatomic, assign) NSInteger nowFMIndex;      //当前播放的FM索引

@end

@implementation FMPlayView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        [ZimuAudioPlayer shareInstance].delegate = self;
        [ZimuAudioPlayer shareInstance].zimuDelegate = self;
        
        [self setSubviews];
    }
    return self;
}

- (void)initAudioPlayer{
    if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateStopped || [ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateReady) {
        [self playFM];
    }else if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStatePaused){
        [[ZimuAudioPlayer shareInstance] resume];
    }
}

- (void)playFM{
    NSURL *url = [NSURL URLWithString:_fmURL];
    STKDataSource *dataSource = [STKAudioPlayer dataSourceFromURL:url];
    [[ZimuAudioPlayer shareInstance] setDataSource:dataSource withQueueItemId:[[SampleQueueId alloc] initWithUrl:url andCount:0]];
}

- (void)timerFiring:(CGFloat)duration progress:(CGFloat)progress{
    _progressLabel.text = [NSString stringWithFormat:@"%02i:%02i",((int)progress)/60, ((int)progress)%60];
    _totalTimeLabel.text = [NSString stringWithFormat:@"%02i:%02i",((int)duration)/60, ((int)duration)%60];
    _progressPercent = (CGFloat)progress / duration;
    dispatch_async(dispatch_get_main_queue(), ^{
        _slider.value = _progressPercent;
    });
}


- (void)setSubviews{
    //fm背景图
    _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    _bgImageView.image = [UIImage imageNamed:@"fm_beijing"];
    [self addSubview:_bgImageView];
    
    //播放进度
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_bgImageView.frame), self.width, 5)];
    _slider.center = CGPointMake(self.centerX, CGRectGetMaxY(_bgImageView.frame));
    UIImage *image = [UIImage imageWithColor:themeYellow size:CGSizeMake(15, 15)];
    image = [image imageAddCornerWithRadious:image.size.height/2.0 size:image.size];
    [_slider setThumbImage:image forState:UIControlStateNormal];
    [_slider setMinimumTrackTintColor:themeYellow];
    [_slider setMaximumTrackTintColor:[UIColor colorWithHexString:@"c0c0c0"]];
    [self addSubview:_slider];
    [[_slider rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(id x) {
        CGFloat seekTime =  [ZimuAudioPlayer shareInstance].duration * _slider.value;
        [[ZimuAudioPlayer shareInstance] seekToTime:seekTime];
    }];
    
    //已播放时间
    _progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_slider.frame) + 5, 80, 15)];
    _progressLabel.textAlignment = NSTextAlignmentLeft;
    _progressLabel.font = [UIFont systemFontOfSize:11];
    _progressLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_progressLabel];
    
    //总时长label
    _totalTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 10 - 80, CGRectGetMinY(_progressLabel.frame), 80, 15)];
    _totalTimeLabel.textAlignment = NSTextAlignmentRight;
    _totalTimeLabel.font = [UIFont systemFontOfSize:11];
    _totalTimeLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_totalTimeLabel];
    
    
    //开始、暂停按钮
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_startButton setBackgroundImage:[UIImage imageNamed:@"fm_play"] forState:UIControlStateNormal];
    [_startButton setBackgroundImage:[UIImage imageNamed:@"fm_pause"] forState:UIControlStateSelected];
    _startButton.size = _startButton.currentBackgroundImage.size;
    _startButton.center = CGPointMake(self.centerX, CGRectGetMaxY(_slider.frame) + 20 + _startButton.height/2.0);
    _startButton.selected = YES;
    [self addSubview:_startButton];

    [[_startButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (!_startButton.selected) {
            //正在播放状态
            NSLog(@"state : %li",[ZimuAudioPlayer shareInstance].state);
            if ([ZimuAudioPlayer shareInstance].state == STKAudioPlayerStateStopped ) {
                [self playFM];
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
    _backWardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backWardButton setBackgroundImage:[UIImage imageNamed:@"fm_houtui"] forState:UIControlStateNormal];
    _backWardButton.size = _backWardButton.currentBackgroundImage.size;
    CGFloat gap = 40/375.0 * kScreenWidth;
    _backWardButton.center = CGPointMake(CGRectGetMinX(_startButton.frame) - gap - _backWardButton.width/2.0, _startButton.centerY);
    [self addSubview:_backWardButton];
    [[_backWardButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"快退15秒");
        double currentTime = [ZimuAudioPlayer shareInstance].progress;
        double targetTime = currentTime - 15;
        if (targetTime <= 0) {
            targetTime = 0;
        }
        [[ZimuAudioPlayer shareInstance] seekToTime:targetTime];
    }];
    
    //下一曲
    _forwardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forwardButton setBackgroundImage:[UIImage imageNamed:@"fm_kuaijin"] forState:UIControlStateNormal];
    _forwardButton.size = _forwardButton.currentBackgroundImage.size;
    _forwardButton.center = CGPointMake(CGRectGetMaxX(_startButton.frame) + gap + _forwardButton.width/2.0, _startButton.centerY);
    [self addSubview:_forwardButton];
    
    [[_forwardButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
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




- (void)setFmDetailModel:(FMDetailModel *)fmDetailModel{
    if (_fmDetailModel != fmDetailModel) {
        _fmDetailModel = fmDetailModel;
        _fmURL = [imagePrefixURL stringByAppendingString:_fmDetailModel.audioUrl];
        [self initAudioPlayer];
        
        //刷新数据
        //图片
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:[imagePrefixURL stringByAppendingString:fmDetailModel.fmImg]] placeholderImage:[UIImage imageNamed:@"fm_beijing"]];
    }
}

@end
