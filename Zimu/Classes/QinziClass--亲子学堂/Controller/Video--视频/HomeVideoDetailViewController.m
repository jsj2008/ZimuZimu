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

@interface HomeVideoDetailViewController ()<ZFPlayerDelegate, CommentBarDelegate>
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

@end

@implementation HomeVideoDetailViewController

- (void)dealloc{
    [self.player removeFromSuperview];
    self.player = nil;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
    
    [self getVideoDetailData];      //获取视频信息
    [self getHotVideoData];         //获取推荐视频
    [self getVideoCommentData];     //获取视频评论
    
    [self makePlayer];
    
    [self makeTableView];
    
    [self setupCommentBar];
    
    //判断是否登录
    NSString *token = userToken;
    if (token.length != 0) {
        //登录
        [self checkWhetherSelectVideo];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    // pop回来时候是否自动播放
//    if (self.navigationController.viewControllers.count == 2 && self.player && self.isPlaying) {
//        self.isPlaying = NO;
//        [self.player play];
//        
//    }
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
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
//        controllerView.trySeePrice = 321;
        [self setPlayerModelWithTitle:@"塑料袋看风景" videoStr:@""];
        [_player playerControlView:controllerView playerModel:_playerModel];
        
        // 设置代理
        _player.delegate = self;
        
        // 打开下载功能（默认没有这个功能）
        _player.hasDownload    = YES;
        //设置试看时间，如果没有试看则设置试看时间为0 isTrySee设为NO
//        _player.trySeeTime = 10;
        _player.isTrysee = NO;
        // 打开预览图
        self.player.hasPreviewView = YES;
        //    ZFPlayerControlView
        //自动播放
        [self.player autoPlayTheVideo];
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



- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
//        _playerModel.videoURL         = [NSURL URLWithString:@"http://on9fin031.bkt.clouddn.com/video/20170517150000012312"];
        _playerModel.fatherView       = _playerFatherView;
        
    }
    return _playerModel;
}
- (void)setPlayerModelWithTitle:(NSString *)title videoStr:(NSString *)videoStr{
//    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.placeholderImage = [UIImage imageNamed:@"loading_bgView1"];
        _playerModel.videoURL         = [NSURL URLWithString:videoStr];
        _playerModel.title = title;
        _playerModel.fatherView       = _playerFatherView;
        
//    }
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


#pragma mark - 获取视频详情
- (void)getVideoDetailData{
    AppQueryVideoApi *appQueryVideoApi = [[AppQueryVideoApi alloc]initWithVideoId:_videoId];
    [appQueryVideoApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
        [self.player autoPlayTheVideo];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return;
        }
        ExpertDetailModel *expertDetailModel = [ExpertDetailModel yy_modelWithDictionary:dataDic[@"object"]];
        _detailView.expertDetailModel = expertDetailModel;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
        [MBProgressHUD showMessage_WithoutImage:@"网络出错" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
        [MBProgressHUD showMessage_WithoutImage:@"网络出错" toView:self.view];
    }];
}


#pragma mark - 去登陆
- (void)gotoLogin{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    [self presentViewController:newLoginVC animated:YES completion:nil];
}



@end
