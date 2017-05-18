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

@interface FMViewController ()<UITextFieldDelegate>

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
    [self.view addSubview:_commentBar];
}


#pragma mark - 获取fm详情数据
- (void)getFMDetailData{
    GetFmByPrimaryKeyApi *getFmByPrimaryKeyApi = [[GetFmByPrimaryKeyApi alloc]initWithFMId:_fmId];
    [getFmByPrimaryKeyApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
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
        FMDetailModel *fmDetailModel = [FMDetailModel yy_modelWithDictionary:dataDic[@"object"]];
        _FMPlayView.fmDetailModel = fmDetailModel;
        _tableView.fmDetailModel = fmDetailModel;
        [self getFMExpertData:fmDetailModel.createExp];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return;
        }
        ExpertDetailModel *expertDetailModel = [ExpertDetailModel yy_modelWithDictionary:dataDic[@"object"]];
        _tableView.expertDetailModel = expertDetailModel;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
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
//                VideoCommentModel *videoCommentModel = [VideoCommentModel yy_modelWithDictionary:dic];
//                [_fmCommentModelArray addObject:videoCommentModel];
            }
        }
//        _detailView.videoCommentModelArray = _fmCommentModelArray;
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
    }];
}

@end


