//
//  BrowsVideoViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BrowsVideoViewController.h"
#import "BrowsVideoCell.h"
#import "MyCollectionCell.h"
#import "GetMyFavouriteArticleApi.h"
#import "GetMyFavouriteVideoListApi.h"
#import "MBProgressHUD+MJ.h"
#import "MyCollectionArticleModel.h"
#import <MJRefresh.h>
#import "MyCollectionVideoModel.h"

static NSString *artCell = @"MyCollectionCell";

@interface BrowsVideoViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *articleTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation BrowsVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    _dataArray = [NSMutableArray array];
    [self createCollectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createCollectionView{
    if (!_articleTableView) {
        _articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight - 101) style:UITableViewStylePlain];
        _articleTableView.backgroundColor = themeGray;
        
        
        [_articleTableView registerClass:[MyCollectionCell class] forCellReuseIdentifier:artCell];
        
        _articleTableView.delegate = self;
        _articleTableView.dataSource = self;
        
        _articleTableView.mj_footer  = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
        _articleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reFresh)];
        [_articleTableView.mj_header beginRefreshing];
        
        _articleTableView.tableFooterView = [[UIView alloc] init];
        [self.view addSubview:_articleTableView];
    }}

#pragma mark - colectionView代理、数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:artCell forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsZero;
    NSDictionary *dic = _dataArray[indexPath.row];
    MyCollectionVideoModel *model = [MyCollectionVideoModel yy_modelWithJSON:dic];
    cell.titleString = model.videoTitle;
    cell.bgImageString = model.videoImg;
    cell.countString = [NSString stringWithFormat:@"%li", model.readNum];
    cell.collectionType = CollectionTypeVideo;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 * kScreenWidth / 375.0;
}
#pragma mark - 网络请求
- (void)getMore{
    NSDictionary *dic = [_dataArray lastObject];
    MyCollectionVideoModel *model = [MyCollectionVideoModel yy_modelWithJSON:dic];
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
    GetMyFavouriteVideoListApi *artApi = [[GetMyFavouriteVideoListApi alloc] initWithEndTime:endTime];
    [artApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSString *jsonData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", jsonData);
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请检查网络" toView:self.view];
            return ;
        }else{
            NSArray *nowData = dataDic[@"items"];
            [_dataArray addObjectsFromArray:dataDic[@"items"]];
            [_articleTableView.mj_footer endRefreshing];
            [_articleTableView.mj_header endRefreshing];
            if (nowData.count < 10) {
                [_articleTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [_articleTableView reloadData];
            
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

@end
