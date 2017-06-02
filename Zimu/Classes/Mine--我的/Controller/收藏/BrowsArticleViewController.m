//
//  BrowsArticleViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BrowsArticleViewController.h"
#import "BrowsArticleCell.h"
#import "MyCollectionCell.h"
#import "GetMyFavouriteArticleApi.h"
#import "MBProgressHUD+MJ.h"
#import "MyCollectionArticleModel.h"
#import "ArticleViewController.h"
#import "ZMBlankView.h"
#import <MJRefresh.h>

static NSString *artCell = @"MyCollectionCell";
@interface BrowsArticleViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *articleTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation BrowsArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeWhite;
    [self createTableView];
    _dataArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTableView{
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
    }
}

#pragma mark - 表视图代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:artCell forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsZero;
    NSDictionary *dic = _dataArray[indexPath.row];
    MyCollectionArticleModel *model = [MyCollectionArticleModel yy_modelWithJSON:dic];
    cell.titleString = model.articleTitle;
    cell.bgImageString = model.articleImg;
    cell.countString = [NSString stringWithFormat:@"%li", model.readNum];
    cell.collectionType = CollectionTypeArticle;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 * kScreenWidth / 375.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ArticleViewController *articleVC = [[ArticleViewController alloc]init];
    NSDictionary *dic = _dataArray[indexPath.row];
    MyCollectionArticleModel *itemModel = [MyCollectionArticleModel yy_modelWithJSON:dic];
    articleVC.articleID = itemModel.articleId;
    articleVC.articleTitle = itemModel.articleTitle;
    [self.navigationController pushViewController:articleVC animated:YES];
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
    MyCollectionArticleModel *model = [MyCollectionArticleModel yy_modelWithJSON:dic];
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
    GetMyFavouriteArticleApi *artApi = [[GetMyFavouriteArticleApi alloc] initWithEndTime:endTime];
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
                [_articleTableView.mj_footer endRefreshing];
                [_articleTableView.mj_header endRefreshing];
                if (nowData.count < 10) {
                    [_articleTableView.mj_footer endRefreshingWithNoMoreData];
                }
                [_articleTableView reloadData];
            }

        }

    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self noNet];
    }];
}
@end
