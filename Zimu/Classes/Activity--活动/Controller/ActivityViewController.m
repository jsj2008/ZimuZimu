//
//  ActivityViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityViewController.h"
#import "UIImage+ZMExtension.h"
#import "ActivityTableView.h"
#import "GetAppOfflineCourseListApi.h"
#import "ActivityListModel.h"
#import "MBProgressHUD+MJ.h"
#import "ZMBlankView.h"

@interface ActivityViewController ()

@property (nonatomic, strong) ActivityTableView *activityTableView;
@property (nonatomic, strong) NSMutableArray *activityListModelArray;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动报名";
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
//    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    /*创建activityTableView*/
    [self setupActivityTableView];
    
    /*获取数据*/
    [self getActivityListData];
}

/**
 *  activityTableView
 */
- (void)setupActivityTableView{
    _activityTableView = [[ActivityTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_activityTableView];
}


#pragma mark - 获取列表数据
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getActivityListData];
    }];
    [self.view addSubview:blankview];
}

- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getActivityListData];
    }];
    [self.view addSubview:blankview];
}

- (void)getActivityListData{
    GetAppOfflineCourseListApi *getAppOfflineCourseListApi = [[GetAppOfflineCourseListApi alloc]init];
    [getAppOfflineCourseListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据出错" toView:self.view];
            [self noNet];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"暂无数据" toView:self.view];
            [self noData];
            return;
        }
        NSArray *dataArray = dataDic[@"items"];
        if (dataArray.count != 0) {
            if (_activityListModelArray) {
                [_activityListModelArray removeAllObjects];
                _activityListModelArray = nil;
            }
            _activityListModelArray = [NSMutableArray arrayWithCapacity:dataArray.count];
            for (NSDictionary *dic in dataArray) {
                ActivityListModel *model = [ActivityListModel yy_modelWithDictionary:dic];
                [_activityListModelArray addObject:model];
            }
            _activityTableView.activityListModelArray = _activityListModelArray;
        }
        if (_activityListModelArray.count == 0) {
            [self noData];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [MBProgressHUD showMessage_WithoutImage:@"获取活动数据失败" toView:self.view];
        [self noNet];
    }];
}


@end
