//
//  PreviewPhotoVideoViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PreviewPhotoVideoViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import <SVProgressHUD/SVProgressHUD.h>


#define SCREEN_WIDTH kScreenWidth
#define SCREEN_HEIGHT kScreenHeight

@interface PreviewPhotoVideoViewController ()

//用于预览的参数
@property (nonatomic, assign) BOOL isVideo;
@property (nonatomic, strong) UIImage *previewImg;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, copy) NSString *videoPath;

//UI控件
@property (nonatomic, strong) UIButton *saveBtn;
@property (nonatomic, strong) UIButton *playBtn;

/**
 *  声明播放视频的控件属性[既可以播放视频也可以播放音频]
 */
@property (nonatomic,strong)AVPlayer *player;
/**
 *  播放的总时长
 */
@property (nonatomic,assign)CGFloat sumPlayOperation;

@end

@implementation PreviewPhotoVideoViewController

- (instancetype)initWithPhoto:(UIImage *)image{
    self = [super init];
    if (self) {
        _previewImg = image;
        _isVideo = NO;
    }
    return self;
}
- (instancetype)initWithVideoPath:(NSString *)path{
    self = [super init];
    if (self) {
        _videoPath = path;
        _isVideo = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    // Do any additional setup after loading the view.
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 设置UI
- (void)setUI{
    //添加预览
    NSLog(@"asdf0");
    if (!_isVideo) {
        [self.view addSubview:self.imgView];
    }else{
        [self setupPlayer];
        [self startPlay];
    }
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, 30, 50, 50);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    NSLog(@"asdf1");
    
    //再添加视频播放、保存按钮
    [self.view addSubview:self.saveBtn];
    if (_isVideo) {
        [self.view addSubview:self.playBtn];
        _playBtn.hidden = YES;
    }
    
    //设置返回按钮
    NSLog(@"asdf2");
}
#pragma mark - 视频预览
- (void)setupPlayer{
    NSString *playString = self.videoPath;
    //设置播放的项目
    NSURL *url1 = [NSURL fileURLWithPath:playString];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url1];
    //初始化player对象
    self.player = [[AVPlayer alloc] initWithPlayerItem:item];
    //设置播放页面
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    //设置播放页面的大小
    layer.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    //设置播放窗口和当前视图之间的比例显示内容
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.view.layer addSublayer:layer];
    //设置播放的默认音量值
    self.player.volume = 1.0f;
    //设置播放器进度监控
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlayer) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];

}
- (void)stopPlayer
{
    [self.player pause];
    _playBtn.hidden = NO;
    
}

#pragma mark - 懒加载控件
- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_saveBtn];
        [_saveBtn setImage:[UIImage imageNamed:@"save"] forState:UIControlStateNormal];
        [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view).with.offset(-20);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        [_saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}
- (UIButton *)playBtn{
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:_playBtn];
        [_playBtn setImage:[UIImage imageNamed:@"home_bofang"] forState:UIControlStateNormal];
        [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
        }];
        [_playBtn addTarget:self action:@selector(startPlay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
        _imgView.image = _previewImg;
    }
    return _imgView;
}

#pragma mark - 按钮点击事件
- (void)startPlay{
    [_player seekToTime:kCMTimeZero];
    [self.player play];
    _playBtn.hidden = YES;
}
- (void)save{
    if (_isVideo) {
        UISaveVideoAtPathToSavedPhotosAlbum(_videoPath, self, @selector(video:didFinishSavingWithError:contextInfo:), NULL);
    }else{
        UIImageWriteToSavedPhotosAlbum(_previewImg, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
}
- (void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 保存图片和视频回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    if(error != NULL){
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
    }else{
        [SVProgressHUD showSuccessWithStatus:@"图片已保存到相册"];
    }
}

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(error != NULL){
        [SVProgressHUD showErrorWithStatus:@"保存视频失败"];
        
    }else{
        [SVProgressHUD showSuccessWithStatus:@"视频已保存到相册"];
    }
}
@end
