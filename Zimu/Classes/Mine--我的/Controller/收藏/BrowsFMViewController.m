//
//  BrowsFMViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BrowsFMViewController.h"
#import "SubscribeFreeFMCell.h"
#import "MBProgressHUD+MJ.h"
#import <MJRefresh.h>
#import "MyCollectionCell.h"
#import "FindListCell.h"
#import "MyCollectionFMModel.h"
#import "GetMyFavouriteFmListApi.h"
#import "FMViewController.h"
#import "ZMBlankView.h"

static NSString *fmCell = @"MyCollectionCell";
@interface BrowsFMViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UITableView *fmTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BrowsFMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    _dataArray = [NSMutableArray array];
    [self createTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)createTableView{
    if (!_fmTableView) {
        _fmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight - 101) style:UITableViewStylePlain];
        _fmTableView.backgroundColor = themeGray;
        
        [_fmTableView  registerClass:[MyCollectionCell class] forCellReuseIdentifier:fmCell];
        
        _fmTableView.dataSource = self;
        _fmTableView.delegate = self;
        
        _fmTableView.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
        _fmTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reFresh)];
        [_fmTableView.mj_header beginRefreshing];
        
        _fmTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_fmTableView];
    }
}

#pragma mark - 数据源和代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:fmCell forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsZero;
    NSDictionary *dic = _dataArray[indexPath.row];
    MyCollectionFMModel *model = [MyCollectionFMModel yy_modelWithJSON:dic];
    cell.titleString = model.fmTitle;
    cell.bgImageString = model.fmImg;
    cell.countString = [NSString stringWithFormat:@"%li", model.readNum];
    cell.collectionType = CollectionTypeFM;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 * kScreenWidth / 375.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = _dataArray[indexPath.row];
    MyCollectionFMModel *itemModel = [MyCollectionFMModel yy_modelWithJSON:dic];
    FMViewController *fmVC = [[FMViewController alloc]init];
    fmVC.fmId = itemModel.fmId;
    [self.navigationController pushViewController:fmVC animated:YES];

}
#pragma mark - 网络请求
- (void)noData{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoData afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self reFresh];
    }];
    [self.view addSubview:blankview];
}
- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self reFresh];
    }];
    [self.view addSubview:blankview];
}

- (void)getMore{
    NSDictionary *dic = [_dataArray lastObject];
    MyCollectionFMModel *model = [MyCollectionFMModel yy_modelWithJSON:dic];
    CGFloat lastTime = [model.favoriteTime floatValue] / 1000;
    NSInteger iTime = [[NSString stringWithFormat:@"%.0f", lastTime] integerValue];
    [self getData:iTime];
}
- (void)reFresh{
    double nowTime = [[NSDate date] timeIntervalSince1970];
    NSInteger iTime = [[NSString stringWithFormat:@"%.0f", nowTime] integerValue];
    _dataArray = [NSMutableArray array];
    [self getData:iTime];
}
- (void)getData:(NSInteger)endTime{
    GetMyFavouriteFmListApi *artApi = [[GetMyFavouriteFmListApi alloc] initWithEndTime:endTime];
    [artApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            [self noNet];
            return ;
        }else{
            NSArray *nowData = dataDic[@"items"];
            [_dataArray addObjectsFromArray:dataDic[@"items"]];
            if (_dataArray.count == 0) {
                [self noData];
            }else{
                [_fmTableView.mj_footer endRefreshing];
                [_fmTableView.mj_header endRefreshing];
                if (nowData.count < 10) {
                    [_fmTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [_fmTableView reloadData];
            }
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self noNet];
    }];
}

@end
