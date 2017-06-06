//
//  FMViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMViewController.h"
#import "FMPlayView.h"
#import "FMTableView.h"
#import "GetFmByPrimaryKeyApi.h"
#import "GetExpertByPrimaryKeyApi.h"
#import "GetFmCommentListApi.h"
#import "FMDetailModel.h"
#import "ExpertDetailModel.h"
#import "MBProgressHUD+MJ.h"
#import "UIView+SnailUse.h"
#import "CommentBar.h"
#import "CommentModel.h"
#import "InsertFmCommentApi.h"
#import "GetWhetherFavoriteFmApi.h"
#import "InsertFmCollectionApi.h"
#import "InsertCollectionModel.h"
#import "ZMBlankView.h"
#import "NewLoginViewController.h"
#import "ZMBlankView.h"

@interface FMViewController ()<UITextFieldDelegate, CommentBarDelegate, LoginViewControllerDelegate>

@property (nonatomic, strong) FMPlayView *FMPlayView;
@property (nonatomic, strong) FMTableView *tableView;
@property (nonatomic, strong) CommentBar *commentBar;      //评论栏

@property (nonatomic, strong) NSMutableArray *fmCommentModelArray;

@end

@implementation FMViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"心灵FM";
    self.view.backgroundColor = themeGray;
    
    
    [self.view addSubview:self.tableView];
    [self setupCommentBar];
    
    [self getFMDetailData];
    [self getFMCommentData];
    
    //判断是否登录
    NSString *token = userToken;
    if (![token isEqualToString:@"logout"] && token != nil) {
        //登录
        [self checkWhetherCollectFM];
    }
    
}

/**
 *  创建FMTableView
 */
- (FMTableView *)tableView{
    if (!_tableView) {
        _tableView = [[FMTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 49 - 64) style:UITableViewStylePlain];
        _tableView.backgroundColor = themeGray;
        _tableView.tableHeaderView = self.FMPlayView;
    }
    return _tableView;
}

- (FMPlayView *)FMPlayView{
    if (!_FMPlayView) {
        UIImage *buttonImage = [UIImage imageNamed:@"fm_pause"];
        CGSize imageSize = buttonImage.size;        //播放按钮的大小
        _FMPlayView = [[FMPlayView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth + 40 + imageSize.height)];
        _FMPlayView.backgroundColor = themeWhite;
    }
    return _FMPlayView;
}

- (void)setupCommentBar{
    _commentBar = [UIView commentBar];
    _commentBar.delegate = self;
    [self.view addSubview:_commentBar];
}

#pragma mark - CommentBarDelegate
//分享
- (void)commentBarShare{
    
}
//收藏
- (void)commentBarSelect:(UIButton *)button{
    //判断是否登录
    if ([userToken isEqualToString:@"logout"] || userToken == nil) {
        //去登录
        [self gotoLogin];
    }else{
        //收藏
        button.selected = !button.selected;
        [self collectFM];
    }
}
//评论
- (void)commentBarComment{
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
//发表评论
- (void)commentBarSubmit:(NSString *)text{
    //判断是否登录
    if ([userToken isEqualToString:@"logout"] || userToken == nil) {
        //去登录
        [self gotoLogin];
    }else{
        //发表评论
        [self insertFMCommentDataWithText:text];
    }
}



#pragma mark - 获取fm详情数据
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
    }];
    [self.view addSubview:blankview];
}
- (void)timeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
    }];
    [self.view addSubview:blankview];
}
- (void)lostSever{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
    }];
    [self.view addSubview:blankview];
}


- (void)getFMDetailData{
    GetFmByPrimaryKeyApi *getFmByPrimaryKeyApi = [[GetFmByPrimaryKeyApi alloc]initWithFMId:_fmId];
    [getFmByPrimaryKeyApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
<<<<<<< HEAD
            [self noData];
=======
//            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            [self lostSever];
>>>>>>> origin/master
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
<<<<<<< HEAD
=======
//            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            [self noData];
            return;
        }
        if (!dataDic[@"object"]) {
>>>>>>> origin/master
            [self noData];
            return;
        }
        
        FMDetailModel *fmDetailModel = [FMDetailModel yy_modelWithDictionary:dataDic[@"object"]];
        _FMPlayView.fmDetailModel = fmDetailModel;
        _tableView.fmDetailModel = fmDetailModel;
        [self getFMExpertData:fmDetailModel.createExp];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
<<<<<<< HEAD
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
            
=======
//        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
        if (request.error.code == -1009) {
            [self noNet];
        }else if (request.error.code == -1011){
            [self timeOut];
        }else{
            [self lostSever];
>>>>>>> origin/master
        }
    }];
}

#pragma mark - 获取fm作者信息
- (void)getFMExpertData:(NSString *)expertId{
    GetExpertByPrimaryKeyApi *getExpertByPrimaryKeyApi = [[GetExpertByPrimaryKeyApi alloc]initWithExpertId:expertId];
    [getExpertByPrimaryKeyApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常" toView:self.view];
            return;
        }
        ExpertDetailModel *expertDetailModel = [ExpertDetailModel yy_modelWithDictionary:dataDic[@"object"]];
        _tableView.expertDetailModel = expertDetailModel;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
<<<<<<< HEAD
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
=======
//        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
>>>>>>> origin/master
    }];
}

#pragma mark - 获取fm评论
- (void)getFMCommentData{
    GetFmCommentListApi *getFMCommentApi = [[GetFmCommentListApi alloc]initWithFMId:_fmId];
    [getFMCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
        if (_fmCommentModelArray) {
            [_fmCommentModelArray removeAllObjects];
            _fmCommentModelArray = nil;
        }
        _fmCommentModelArray = [NSMutableArray array];
        NSArray *dataArray = dataDic[@"items"];
        if (dataArray.count) {
            for (NSDictionary *dic in dataArray) {
                CommentModel *fmCommentModel = [CommentModel yy_modelWithDictionary:dic];
                [_fmCommentModelArray addObject:fmCommentModel];
            }
        }
        _tableView.fmCommentModelArray = _fmCommentModelArray;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
<<<<<<< HEAD
        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
=======
//        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
>>>>>>> origin/master
    }];
}

#pragma mark - 插入评论数据
- (void)insertFMCommentDataWithText:(NSString *)text{
    InsertFmCommentApi *insertFMCommentApi = [[InsertFmCommentApi alloc]initWithFmId:_fmId commentVal:text];
    [insertFMCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"评论失败" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.0];
            return;
        }
        [MBProgressHUD showMessage_WithoutImage:@"发表成功" toView:self.view];
        _commentBar.textField.text = @"";
        [_commentBar.textField resignFirstResponder];
        [self refreshData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"评论失败" toView:self.view];
    }];
}

//刷新数据
- (void)refreshData{
    [self getFMCommentData];
}

#pragma mark - 查询是否已收藏FM
- (void)checkWhetherCollectFM{
    GetWhetherFavoriteFmApi *getWhetherFavoriteFmApi = [[GetWhetherFavoriteFmApi alloc]initWithFMId:_fmId];
    [getWhetherFavoriteFmApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
//        [MBProgressHUD showMessage_WithoutImage:@"查询收藏状态失败" toView:self.view];
    }];
}

#pragma mark - 收藏FM
- (void)collectFM{
    BOOL hasCollected = _commentBar.hasCollected;
    InsertFmCollectionApi *insertFMCollectionApi = [[InsertFmCollectionApi alloc]initWithFMId:_fmId];
    [insertFMCollectionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
//        [MBProgressHUD showMessage_WithoutImage:@"网络出错" toView:self.view];
    }];
}


#pragma mark - 去登陆
- (void)gotoLogin{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    newLoginVC.delegate = self;
    [self presentViewController:newLoginVC animated:YES completion:nil];
}
//LoginViewControllerDelegate
- (void)loginSuccess{
    [self checkWhetherCollectFM];
}

#pragma mark - 空白页
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:NO btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
        [self getFMCommentData];
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            //登录
            [self checkWhetherCollectFM];
        }
    }];
    [self.view addSubview:blankview];
}
- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
        [self getFMCommentData];
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            //登录
            [self checkWhetherCollectFM];
        }
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
        [self getFMCommentData];
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            //登录
            [self checkWhetherCollectFM];
        }
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getFMDetailData];
        [self getFMCommentData];
        NSString *token = userToken;
        if (![token isEqualToString:@"logout"] && token != nil) {
            //登录
            [self checkWhetherCollectFM];
        }
    }];
    [self.view addSubview:blankview];
}


@end


