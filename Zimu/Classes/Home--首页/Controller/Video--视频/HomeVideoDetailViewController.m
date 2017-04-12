//
//  HomeVideoDetailViewController.m
//  Zimu
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeVideoDetailViewController.h"
#import "ZFPlayer.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <Masonry/Masonry.h>
#import <ZFDownload/ZFDownloadManager.h>
#import "HomeVideoDeatilView.h"

@interface HomeVideoDetailViewController ()<ZFPlayerDelegate>
/*播放器*/
@property (nonatomic, strong) ZFPlayerView *player;
@property (nonatomic, strong) UIView *playerFatherView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, assign) BOOL isPlaying;

/* 详细信息 */
@property (nonatomic, strong) HomeVideoDeatilView *detailView;
@end

@implementation HomeVideoDetailViewController

- (void)dealloc{
    [self.player removeFromSuperview];
    self.player = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.title = @"视频详情";
    

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    [self makePlayer];
    
    [self makeTbleView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == 2 && self.player && self.isPlaying) {
        self.isPlaying = NO;
        [self.player play];
        
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count == 3 && self.player && !self.player.isPauseByUser){
        self.isPlaying = YES;
        [self.player pause];
    }
}
- (void)viewDidDisappear:(BOOL)animated{
    [self.player removeFromSuperview];
    self.player = nil;
}
#pragma mark - 创建播放器
- (void)makePlayer{
    //player的父视图
    _playerFatherView  = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 0.56 * kScreenWidth)];
    _playerFatherView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_playerFatherView];
    
    //播放器
    if (!_player) {
        _player = [[ZFPlayerView alloc] init];
        ZFPlayerControlView *controllerView = [[ZFPlayerControlView alloc] init];
        controllerView.trySeePrice = 321;
        [_player playerControlView:controllerView playerModel:self.playerModel];
        
        // 设置代理
        _player.delegate = self;
        
        // 打开下载功能（默认没有这个功能）
        _player.hasDownload    = YES;
        //设置试看时间，如果没有试看则设置试看时间为0 isTrySee设为NO
        _player.trySeeTime = 10;
        _player.isTrysee = YES;
        // 打开预览图
        self.player.hasPreviewView = YES;
        //    ZFPlayerControlView
        //自动播放
        [self.player autoPlayTheVideo];
    }
    
}
- (void)makeTbleView{
    if (!_detailView) {
        _detailView = [[HomeVideoDeatilView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_playerFatherView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_playerFatherView.frame)) style:UITableViewStylePlain];
        
    }
    [self.view addSubview:_detailView];
}
- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = @"这里设置视频标题";
        _playerModel.videoURL         = [NSURL URLWithString:@"http://on59kdhax.bkt.clouddn.com/video/20170322105906280310"];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.fatherView       = _playerFatherView;
        
    }
    return _playerModel;
}

// 视频详情页不支持系统转屏
- (BOOL)shouldAutorotate {
    return NO;
}
#pragma mark - ZFdelegate
- (void)zf_playerBackAction {
    [self.player removeFromSuperview];
    self.player = nil;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
}



@end
