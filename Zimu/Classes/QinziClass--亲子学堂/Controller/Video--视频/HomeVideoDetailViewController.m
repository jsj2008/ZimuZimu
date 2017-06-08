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
#import "MBProgressHUD+MJ.h"
#import "UIView+SnailUse.h"
#import "CommentBar.h"
#import "NewLoginViewController.h"

#import <YTKBatchRequest.h>
#import "AppQueryVideoApi.h"
#import "GetExpertByPrimaryKeyApi.h"
#import "GetHotVideoApi.h"
#import "GetVideoCommentApi.h"
#import "InsertVideoCommentApi.h"
#import "GetWhetherFavoriteVideoApi.h"
#import "VideoDetailModel.h"
#import "HotVideoModel.h"
#import "CommentModel.h"
#import "ExpertDetailModel.h"
#import "InsertVideoCollectionApi.h"
#import "InsertCollectionModel.h"
#import "ZMBlankView.h"
#import "NetWorkStatuesManager.h"

@interface HomeVideoDetailViewController ()<ZFPlayerDelegate, CommentBarDelegate, LoginViewControllerDelegate, ZFPlayerControlViewDelagate>
/*播放器*/
@property (nonatomic, strong) ZFPlayerView *player;
@property (nonatomic, strong) UIView *playerFatherView;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, assign) BOOL isPlaying;

/* 详细信息 */
@property (nonatomic, strong) HomeVideoDeatilView *detailView;
/* 评论栏 */
@property (nonatomic, strong) CommentBar *commentBar;

@property (nonatomic, strong) NSMutableArray *hotVideoModelArray;       //推荐视频数组
@property (nonatomic, strong) NSMutableArray *commentModelArray;        //评论数据数组
@property (nonatomic, assign) ZMNetState *netState;                     //网络状态

@end

@implementation HomeVideoDetailViewController{
    NSInteger _viewControllersCount;
}

- (void)dealloc{
    [_player pause];
     [_player destory];
    NSLog(@"视频走了");
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self getVideoDetailData];      //获取视频信息
    [self getHotVideoData];         //获取推荐视频
    [self getVideoCommentData];     //获取视频评论
    
    [self makePlayer];
    
    [self makeTableView];
    
    [self setupCommentBar];
    
    //判断是否登录
    NSString *token = userToken;
    if (![token isEqualToString:@"logout"] && token != nil) {
        [self checkWhetherSelectVideo];
    }
    _viewControllersCount = self.navigationController.viewControllers.count;
}

#pragma mark - 网络状态的切换

- (void)wifi{
    [super wifi];
//    if (self.netChangeState != ZMNetChangeStateDefault) {
//        
//    }
    if (self.player && !self.player.isPauseByUser) {
        [_player autoPlayTheVideo];
        [_player play];
    }
    if (!self.player) {
        [self makePlayer];
        [_player autoPlayTheVideo];
    }
}
- (void)lostNet{
    [super lostNet];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您的网络已断开" message:@"请检查网络" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        [_player play];
    }];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)mobileData{
    [super mobileData];
    if (self.player && self.isPlaying) {
        [_player pause];
    }
//    if (self.netChangeState == ZMNetChangeStateDefault || self.netChangeState == ZMNetChangeStateLostToWan || self.netChangeState == ZMNetChangeStateWIFIToWan) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您正在使用3G/4G网络观看视频" message:@"是否继续观看" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *continueAction = [UIAlertAction actionWithTitle:@"继续" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [_player autoPlayTheVideo];
            [self.player play];
        }];
        
        [alertController addAction:action];
        [alertController addAction:continueAction];
        [self presentViewController:alertController animated:YES completion:nil];
//    }
}
#pragma mark - 页面进入退出
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    // pop回来时候是否自动播放
    if (self.navigationController.viewControllers.count == _viewControllersCount && self.player && self.isPlaying) {
        self.isPlaying = NO;
        [self.player play];
    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    // push出下一级页面时候暂停
    if (self.navigationController.viewControllers.count != _viewControllersCount && self.player && !self.player.isPauseByUser){
        self.isPlaying = YES;
        [self.player pause];
    }
}

#pragma mark - 创建播放器
- (void)makePlayer{
    //player的父视图
    if (!_playerFatherView) {
        _playerFatherView  = [[UIView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 0.56 * kScreenWidth)];
        _playerFatherView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_playerFatherView];
    }
    
    //播放器
    if (!_player) {
        _player = [[ZFPlayerView alloc] init];
        ZFPlayerControlView *controllerView = [[ZFPlayerControlView alloc] init];
//        controllerView.trySeePrice = 321;
        
        [self setPlayerModelWithTitle:@"塑料袋看风景" videoStr:@""];
        [_player playerControlView:controllerView playerModel:_playerModel];
        
        // 设置代理
        _player.delegate = self;
        
        // 打开下载功能（默认没有这个功能）
        _player.hasDownload    = NO;
        //设置试看时间，如果没有试看则设置试看时间为0 isTrySee设为NO
//        _player.trySeeTime = 10;
        _player.isTrysee = NO;
        // 打开预览图
        self.player.hasPreviewView = YES;
//        [self.player zf_playerResolutionArray:@[@"超清", @"高清", @"流畅"]];
        //    ZFPlayerControlView
        //自动播放
//        [self.player autoPlayTheVideo];
    }
}


- (void)makeTableView{
    if (!_detailView) {
        _detailView = [[HomeVideoDeatilView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_playerFatherView.frame), kScreenWidth, kScreenHeight - CGRectGetMaxY(_playerFatherView.frame) - 49) style:UITableViewStylePlain];
    }
    [self.view addSubview:_detailView];
}

#pragma mark - 评论栏
- (void)setupCommentBar{
    _commentBar = [[CommentBar alloc]initWithFrame:CGRectMake(0, kScreenHeight - 49, kScreenWidth, 49) containNaviHeight:NO];
    _commentBar.delegate = self;
    [self.view addSubview:_commentBar];
}

#pragma mark - CommentBarDelegae
/*分享*/
- (void)commentBarShare{
    NSLog(@"分享");
}
/*收藏*/
- (void)commentBarSelect:(UIButton *)button{
    NSLog(@"收藏");
    //判断是否登录
    if ([userToken isEqualToString:@"logout"]) {
        //去登录
        [self gotoLogin];
    }else{
        //发表评论
        button.selected = !button.selected;
        [self collectVideo];
    }
}
/*点击评论按钮*/
- (void)commentBarComment{
    NSLog(@"评论");
    [_detailView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
/*发表评论*/
- (void)commentBarSubmit:(NSString *)text{
    //判断是否登录
    if ([userToken isEqualToString:@"logout"]) {
        //去登录
        [self gotoLogin];
    }else{
        //发表评论
        [self insertVideoComment:text];
    }
}

- (void)setPlayerModelWithTitle:(NSString *)title videoStr:(NSString *)videoStr{
//    if (!_playerModel) {
    _playerModel                  = [[ZFPlayerModel alloc] init];
    _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
    _playerModel.videoURL         = [NSURL URLWithString:videoStr];
    _playerModel.title            = title;
    _playerModel.fatherView       = _playerFatherView;
//    _playerModel.resolutionDic    = 
    
//    }
}
// 视频详情页不支持系统转屏
- (BOOL)shouldAutorotate {
    return NO;
}
#pragma mark - ZFdelegate
- (void)zf_playerBackAction {
//    [self.player removeFromSuperview];
//    self.player = nil;
//    [_player destory];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
}


#pragma mark - 获取视频详情
- (void)getVideoDetailData{
    AppQueryVideoApi *appQueryVideoApi = [[AppQueryVideoApi alloc]initWithVideoId:_videoId];
    [appQueryVideoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [self noData];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [self noData];
            return;
        }
        if (!dataDic[@"object"]) {
            [self noData];
            return;
        }
        VideoDetailModel *videoDetailModel = [VideoDetailModel yy_modelWithDictionary:dataDic[@"object"]];
        NSLog(@"%@",videoDetailModel);
        _detailView.videoDetailModel = videoDetailModel;
        [self getVideoExpertData:videoDetailModel.expertId];
        
        //播放视频
        NSString *urlString = [NSString stringWithFormat:@"%@%@",imagePrefixURL ,videoDetailModel.videoUrl];
        [self setPlayerModelWithTitle:videoDetailModel.videoTitle videoStr:urlString];
        [_player playerControlView:_playerFatherView  playerModel:_playerModel];
//        [self.player autoPlayTheVideo];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netTimeOut];
        }
    }];
}

#pragma mark - 获取推荐视频
- (void)getHotVideoData{
    GetHotVideoApi *getHotVideoApi = [[GetHotVideoApi alloc]init];
    [getHotVideoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [self noData];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [self noData];
            return;
        }
        if (_hotVideoModelArray) {
            [_hotVideoModelArray removeAllObjects];
            _hotVideoModelArray = nil;
        }
        _hotVideoModelArray = [NSMutableArray array];
        NSArray *dataArray = dataDic[@"items"];
        if (dataArray.count) {
            for (NSDictionary *dic in dataArray) {
                HotVideoModel *hotVideoModel = [HotVideoModel yy_modelWithDictionary:dic];
                [_hotVideoModelArray addObject:hotVideoModel];
            }
        }
        _detailView.hotVideoModelArray = _hotVideoModelArray;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (request.error.code == -1009) {
            [self noNet];
        }else if (request.error.code == -1011){
            [self netTimeOut];
        }else{
            [self netLostServer];
        }
    }];
}

#pragma mark - 获取视频评论
- (void)getVideoCommentData{
    GetVideoCommentApi *getVideoCommentApi = [[GetVideoCommentApi alloc]initWithVideoId:_videoId];
    [getVideoCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return;
        }
        if (_commentModelArray) {
            [_commentModelArray removeAllObjects];
            _commentModelArray = nil;
        }
        _commentModelArray = [NSMutableArray array];
        NSArray *dataArray = dataDic[@"items"];
        if (dataArray.count) {
            for (NSDictionary *dic in dataArray) {
                CommentModel *videoCommentModel = [CommentModel yy_modelWithDictionary:dic];
                [_commentModelArray addObject:videoCommentModel];
            }
        }
        _detailView.videoCommentModelArray = _commentModelArray;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
    }];
}

#pragma mark - 获取视频专家信息
- (void)getVideoExpertData:(NSString *)expertId{
    GetExpertByPrimaryKeyApi *getExpertByPrimaryKeyApi = [[GetExpertByPrimaryKeyApi alloc]initWithExpertId:expertId];
    [getExpertByPrimaryKeyApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return;
        }
        ExpertDetailModel *expertDetailModel = [ExpertDetailModel yy_modelWithDictionary:dataDic[@"object"]];
        _detailView.expertDetailModel = expertDetailModel;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
    }];
}

#pragma mark - 提交评论
- (void)insertVideoComment:(NSString *)text{
    InsertVideoCommentApi *insertVideoCommentApi = [[InsertVideoCommentApi alloc]initWithCommentVal:text videoId:_videoId];
    [insertVideoCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"评论发表失败" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.0];
            return;
        }
        [MBProgressHUD showMessage_WithoutImage:@"评论发表成功" toView:self.view];
        _commentBar.textField.text = @"";
        [_commentBar.textField resignFirstResponder];
        [self getVideoCommentData];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netTimeOut];
            
        }
    }];
}

//刷新数据
- (void)refreshData{
    [self getVideoCommentData];
}


#pragma mark - 查询是否已收藏视频
- (void)checkWhetherSelectVideo{
    GetWhetherFavoriteVideoApi *getWhetherFavoriteVideoApi = [[GetWhetherFavoriteVideoApi alloc]initWithVideoId:_videoId];
    [getWhetherFavoriteVideoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (isTrue) {
            //已收藏
            _commentBar.hasCollected = YES;
            
        }else{
            //未收藏
            _commentBar.hasCollected = NO;
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"查询收藏状态失败" toView:self.view];
    }];
}

#pragma mark - 收藏视频
- (void)collectVideo{
    BOOL hasCollected = _commentBar.hasCollected;
    InsertVideoCollectionApi *insertVideoCollectionApi = [[InsertVideoCollectionApi alloc]initWithVideoId:_videoId];
    [insertVideoCollectionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            _commentBar.hasCollected = hasCollected;        //不改变收藏状态
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            _commentBar.hasCollected = hasCollected;        //不改变收藏状态
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.0];
            return;
        }
        InsertCollectionModel *model = [InsertCollectionModel yy_modelWithDictionary:dataDic[@"object"]];
        NSInteger status = [model.status integerValue];
        if (status) {
            //收藏成功
            [MBProgressHUD showMessage_WithoutImage:@"收藏成功" toView:self.view];
            _commentBar.hasCollected = YES;
        }else{
            //取消收藏成功
            [MBProgressHUD showMessage_WithoutImage:@"取消收藏" toView:self.view];
            _commentBar.hasCollected = NO;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        _commentBar.hasCollected = hasCollected;        //不改变收藏状态
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netTimeOut];
            
        }
    }];
}


#pragma mark - 去登陆
- (void)gotoLogin{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:newLoginVC animated:YES completion:nil];
}
//LoginViewControllerDelegate
- (void)loginSuccess{
    [self checkWhetherSelectVideo];
}

#pragma mark - 空白页
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:NO btnClick:^(ZMBlankView *blView) {
        [self getVideoDetailData];      //获取视频信息
        [self getHotVideoData];         //获取推荐视频
        [self getVideoCommentData];     //获取视频评论
        //判断是否登录
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            [self checkWhetherSelectVideo];
        }
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getVideoDetailData];      //获取视频信息
        [self getHotVideoData];         //获取推荐视频
        [self getVideoCommentData];     //获取视频评论
        //判断是否登录
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            [self checkWhetherSelectVideo];
        }
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getVideoDetailData];      //获取视频信息
        [self getHotVideoData];         //获取推荐视频
        [self getVideoCommentData];     //获取视频评论
        //判断是否登录
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            [self checkWhetherSelectVideo];
        }
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getVideoDetailData];      //获取视频信息
        [self getHotVideoData];         //获取推荐视频
        [self getVideoCommentData];     //获取视频评论
        //判断是否登录
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            [self checkWhetherSelectVideo];
        }
    }];
    [self.view addSubview:blankview];
}


@end
