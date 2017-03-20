//
//  ListenHeartDanmuCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/15.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListenHeartDanmuCell.h"

@interface ListenHeartDanmuCell ()<DanmakuDelegate>
{
    NSTimer *_timer;
    CGFloat _value;
}

@property (nonatomic, strong) NSMutableArray *danmakuSourseArray;
@property (nonatomic, strong) UIImageView *BGImageView;

@end
@implementation ListenHeartDanmuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)onTimeCount{
    _value += 0.1 / _danmakuSourseArray.count;
    if (_value > _danmakuSourseArray.count) {
        _value = 0;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (!_BGImageView) {
            _BGImageView = [[UIImageView alloc]init];
//            NSArray *imageNames = @[@"cycle_01.jpg",@"cycle_02.jpg",@"cycle_03.jpg",@"cycle_04.jpg",@"cycle_05.jpg"];
//            NSMutableArray *images = [NSMutableArray array];
//            for (int index = 0; index < imageNames.count; index++) {
//                UIImage *image = [UIImage imageNamed:imageNames[index]];
//                [images addObject:image];
//            }
//            _BGImageView.animationImages = images;
//            _BGImageView.animationDuration = 20;
//            [_BGImageView startAnimating];
            _BGImageView.image = [UIImage imageNamed:@"cycle_03.jpg"];
            _BGImageView.contentMode = UIViewContentModeScaleAspectFill;
            _BGImageView.clipsToBounds = YES;
            [self.contentView addSubview:_BGImageView];
        }
        [self setupDanmakuView];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _BGImageView.frame = self.bounds;
    _danmuView.frame = self.bounds;
}

- (void)setupDanmakuView{
    _value = 0;
    if (!_danmuView) {
        DanmakuConfiguration *configuration = [[DanmakuConfiguration alloc] init];
        configuration.duration = 6;
        configuration.paintHeight = 18;
        configuration.fontSize = 14;
        configuration.largeFontSize = 15;
        configuration.maxLRShowCount = 30;
        configuration.maxShowCount = 45;
        _danmuView = [[DanmakuView alloc]initWithFrame:CGRectZero configuration:configuration];
        _danmuView.delegate = self;
        [self.contentView addSubview:_danmuView];
        
        _textArray = @[@" 第三方",@"九点十分哈萨克",@"电视",@"的数据福利局",@" 发送到",@"dskfdsflsdfl",@"发送到垃圾",@"电视",@"鼎折覆餗",@"dskfdsflsdfl",@"dskfdsflsdfl",@"方式是",@"dskfdsflsdfl",@" 飞",@"dskfdsflsdfl",@"dskfdsflsdfl",@"第三方飞",@"dskfdsflsdfl",@"dskfdsflsdfl",@" 射雕",@"dskfdsflsdfl",@"   为",@"dskfdsflsdfl",@"dskfdsflsdfl",@"dskfdsflsdfl"];
        
        _danmakuSourseArray = [NSMutableArray array];
        int time = 100;
        int site = 0;
        for (NSString *text in _textArray) {
            DanmakuSource *danmaukuSourse = [[DanmakuSource alloc]init];
            // 时间(毫秒),类型(0:向左滚动 1:顶部 2底部),字体大小(0:中字体 1:大字体),颜色(16进制),用户ID
            time = time +  (arc4random() % 501) + 500;
            site = 1;//arc4random() % 2 + 1;
            danmaukuSourse.p = [NSString stringWithFormat:@"%d,%d,0,4a4a4a,0",time, site];
            danmaukuSourse.m = text;
            [_danmakuSourseArray addObject:danmaukuSourse];
        }
        time = 2000;
        for (NSString *text in _textArray) {
            DanmakuSource *danmaukuSourse = [[DanmakuSource alloc]init];
            // 时间(毫秒),类型(0:向左滚动 1:顶部 2底部),字体大小(0:中字体 1:大字体),颜色(16进制),用户ID
            time = time +  (arc4random() % 501) + 500;
            site = 2;//arc4random() % 2 + 1;
            danmaukuSourse.p = [NSString stringWithFormat:@"%d,,0,fedb18,0",time];
            danmaukuSourse.m = text;
            [_danmakuSourseArray addObject:danmaukuSourse];
        }
        time = 6000;
        for (NSString *text in _textArray) {
            DanmakuSource *danmaukuSourse = [[DanmakuSource alloc]init];
            // 时间(毫秒),类型(0:向左滚动 1:顶部 2底部),字体大小(0:中字体 1:大字体),颜色(16进制),用户ID
            time = time +  (arc4random() % 501) + 500;
            site = 1;//arc4random() % 2 + 1;
            danmaukuSourse.p = [NSString stringWithFormat:@"%d,,0,4cd964,0",time];
            danmaukuSourse.m = text;
            [_danmakuSourseArray addObject:danmaukuSourse];
        }
        [_danmuView prepareDanmakuSources:_danmakuSourseArray];
    }

}


- (void)setTextArray:(NSArray *)textArray{
    if (_textArray != textArray) {
        _textArray = textArray;
        if (_danmakuSourseArray) {
            [_danmakuSourseArray removeAllObjects];
            _danmakuSourseArray = nil;
        }
    }

}



- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView{
    return _value * _danmakuSourseArray.count;
}
- (BOOL)danmakuViewIsBuffering:(DanmakuView *)danmakuView{
    return NO;
}
- (void)danmakuViewPerpareComplete:(DanmakuView *)danmakuView{
    if (_danmuView.isPrepared) {
        if (!_timer) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
        }
        [_danmuView start];
    }
}
- (void)danmakuViewPlayFinished:(DanmakuView *)danmakuView{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [UIView animateWithDuration:6 animations:^{
        _danmuView.frame = CGRectMake(-_danmuView.width, 0, _danmuView.width, _danmuView.height);
        _danmuView.alpha = 0;
    } completion:^(BOOL finished) {
        [_danmuView removeFromSuperview];
        _danmuView = nil;
        [self setupDanmakuView];
        _danmuView.frame = self.bounds;
        [self layoutIfNeeded];
    }];
}

@end
