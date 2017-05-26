//
//  FindViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindViewController.h"
#import "UIImage+ZMExtension.h"
#import "FindTableView.h"

#import "GetParentSchoolListApi.h"
#import "ParentSchoolListModel.h"
#import "MBProgressHUD+MJ.h"
#import "ZimuRefreshGifHeader.h"

@interface FindViewController ()

@property (nonatomic, strong) FindTableView *findTableView;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    self.title = @"亲子学堂";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //创建findTableView
    [self setupFindTableView];
    
    [self getDataNetWork];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
}


/**
 *  FindTableView
 */
- (void)setupFindTableView{
    _findTableView = [[FindTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    //下拉刷新
    [self setupRefreshingHeader];
//    _findTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataNetWork)];
//    [_findTableView.mj_header beginRefreshing];
    //上拉加载
//    _findTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    
    [self.view addSubview:_findTableView];
}

- (void)setupRefreshingHeader{
    ZimuRefreshGifHeader *header = [ZimuRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(getDataNetWork)];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    header.automaticallyChangeAlpha = YES;
    [header beginRefreshing];
    _findTableView.mj_header = header;
}



#pragma mark - 获取数据
//刷新数据
- (void)getDataNetWork{
    //获取当前时间戳
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *time = [NSString stringWithFormat:@"%.0f",timeInterval];
    GetParentSchoolListApi *getParentSchoolListApi = [[GetParentSchoolListApi alloc]initWithEndTime:time];
    
    [getParentSchoolListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [_findTableView.mj_header endRefreshing];
            return ;
        }
        ParentSchoolModel *parentScoolModel = [ParentSchoolModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = parentScoolModel.isTrue;
        if (!isTrue) {
            [_findTableView.mj_header endRefreshing];
            return;
        }
        NSArray *items = parentScoolModel.items;
        NSMutableArray *itemArray = [NSMutableArray arrayWithCapacity:items.count];
        for (NSDictionary *dic in items) {
            ParentSchoolItem *item = [ParentSchoolItem yy_modelWithDictionary:dic];
            [itemArray addObject:item];
        }
        _findTableView.modelArray = itemArray;
        
        [_findTableView.mj_header endRefreshing];
        _findTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [_findTableView.mj_header endRefreshing];
    }];
}
//上拉加载
- (void)loadMoreData{
    //拿到当前tableView数据数组，取出租后一条数据的时间戳，用这个时间戳去请求更多数据
    NSMutableArray *nowDataArray = [NSMutableArray arrayWithArray:_findTableView.modelArray];
    ParentSchoolItem *itemModel = nowDataArray.lastObject;
    NSString *lastTimeStamp  =itemModel.createTime;
    
    GetParentSchoolListApi *getParentSchoolListApi = [[GetParentSchoolListApi alloc]initWithEndTime:lastTimeStamp];
    
    [getParentSchoolListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];

            return ;
        }
        
        ParentSchoolModel *parentScoolModel = [ParentSchoolModel yy_modelWithDictionary:dataDic];
        BOOL isTrue = parentScoolModel.isTrue;
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];
            return;
        }
        NSArray *items = parentScoolModel.items;
        if (!items.count) {
            [_findTableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }else if (items.count < 5){
            [_findTableView.mj_footer endRefreshingWithNoMoreData];
        }
        for (NSDictionary *dic in items) {
            ParentSchoolItem *item = [ParentSchoolItem yy_modelWithDictionary:dic];
            [nowDataArray addObject:item];
        }
        _findTableView.modelArray = nowDataArray;
        
        [_findTableView.mj_footer endRefreshing];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [_findTableView.mj_footer endRefreshing];
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];

    }];
}


@end
