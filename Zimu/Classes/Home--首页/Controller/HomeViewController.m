//
//  HomeViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "UIBarButtonItem+ZMExtension.h"
#import "UMMobClick/MobClick.h"
#import "MJRefresh.h"
#import "UIImage+ZMExtension.h"

#import "TestViewController.h"

#import "HomeNavigationView.h"
#import "HomeTableView.h"
#import "HomeHeaderView.h"

#import "YTKBatchRequest.h"
#import "GetHomeBannerApi.h"
#import "GetHomeRecommendTodayApi.h"
#import "GetHomeFourImageApi.h"
#import "GetRecommendExpertListApi.h"
#import "GetHomeFreeCourseApi.h"
#import "GetHomeCourseIsNotFreeApi.h"
#import "GetHomeFmApi.h"
#import "GetHomeRecommendArticleApi.h"

#import "HomeBannerModel.h"
#import "HomeRecommendTodayModel.h"
#import "HomeFourImageModel.h"
#import "HomeExpertListModel.h"
#import "HomeFreeCourseModel.h"
#import "HomeNotFreeCourseModel.h"
#import "HomeFMModel.h"
#import "HomeArticleModel.h"

#define kHeaderViewHeight 224/375.0 * kScreenWidth           //即轮播图高度

@interface HomeViewController ()<YTKRequestDelegate>

@property (nonatomic, strong) HomeNavigationView *homeNavigationView;   //导航栏
@property (nonatomic, strong) HomeHeaderView *headView;     //做为tableView的headerView

@property (nonatomic, strong) HomeTableView *tableView;

@end

@implementation HomeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    
    //设置系统导航栏为透明
    self.title = @"";
    self.tabBarItem.title = @"首页";
    
    [self setupTableView];
    
    [self setupHeaderView];
    
    [self refresh];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)] forBarMetrics:UIBarMetricsDefault];

}

#pragma mark - observe
- (void)dealloc{
    [self.tableView removeObserver:self forKeyPath:@"contentOffset" context:@"homeTableView"];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    HomeTableView *homeTableview = (HomeTableView *)object;
    if (self.tableView != homeTableview) {
        return;
    }
    
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
}

/**
 *  创建tableView
 */
- (void)setupTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;     //为YES，tableView会往下偏移64
    self.tableView = [[HomeTableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kHeaderViewHeight, 0, 0, 0);
    
    //添加KVO监控
    NSKeyValueObservingOptions option = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:option context:@"homeTableView"];
    
    //刷新控件
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    mj_header.mj_y = 300;
    self.tableView.mj_header = mj_header;

    //导航栏  (要在tableView创建之后)
    self.homeNavigationView = [[HomeNavigationView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 64)];
    self.homeNavigationView.homeTableView = self.tableView;
    [self.view addSubview:self.homeNavigationView];

}

/**
 *  创建headerView,作为tableView的headerView
 */
- (void)setupHeaderView{
    self.headView = [[HomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, kHeaderViewHeight)];
    self.tableView.tableHeaderView = self.headView;
    
    //设置footerView
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 49)];
    footerView.backgroundColor = themeGray;
    self.tableView.tableFooterView = footerView;
    
}


//下拉刷新
- (void)refresh{
    GetHomeBannerApi *getHomeBannerApi = [[GetHomeBannerApi alloc]init];
    GetHomeRecommendTodayApi *getHomeRecommendTodayApi = [[GetHomeRecommendTodayApi alloc]init];
    GetHomeFourImageApi *getHomeFourImageApi = [[GetHomeFourImageApi alloc]init];
    GetRecommendExpertListApi *getRecommendExpertListApi = [[GetRecommendExpertListApi alloc]init];
    GetHomeFreeCourseApi *getHomeFreeCourseApi = [[GetHomeFreeCourseApi alloc]init];
    GetHomeCourseIsNotFreeApi *getHomeCourseIsNotFreeApi = [[GetHomeCourseIsNotFreeApi alloc]init];
    GetHomeFmApi *getHomeFmApi = [[GetHomeFmApi alloc]init];
    GetHomeRecommendArticleApi *articleApi = [[GetHomeRecommendArticleApi alloc]init];
    NSLog(@"start");
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc]initWithRequestArray:@[getHomeBannerApi,
                                                                                   getHomeRecommendTodayApi,
                                                                                   getHomeFourImageApi,
                                                                                   getRecommendExpertListApi,
                                                                                   getHomeFreeCourseApi,
                                                                                   getHomeCourseIsNotFreeApi,
                                                                                   getHomeFmApi,
                                                                                   articleApi]];
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requestArray = batchRequest.requestArray;
        GetHomeBannerApi *getHomeBannerApi = (GetHomeBannerApi *)requestArray[0];
        GetHomeRecommendTodayApi *getHomeRecommendTodayApi = (GetHomeRecommendTodayApi *)requestArray[1];
        GetHomeFourImageApi *getHomeFourImageApi = (GetHomeFourImageApi *)requestArray[2];
        GetRecommendExpertListApi *recommendExpertApi = (GetRecommendExpertListApi *)requestArray[3];
        GetHomeFreeCourseApi *getHomeFreeCourseApi = (GetHomeFreeCourseApi *)requestArray[4];
        GetHomeCourseIsNotFreeApi *getHomeCourseIsNotFreeApi = (GetHomeCourseIsNotFreeApi *)requestArray[5];
        GetHomeFmApi *getHomeFmApi = (GetHomeFmApi *)requestArray[6];
        GetHomeRecommendArticleApi *getArticleApi = (GetHomeRecommendArticleApi *)requestArray[7];
        
        NSDictionary *bannerDataDic = [self parseDataFromRequest:getHomeBannerApi];
        NSDictionary *recommendDataDic = [self parseDataFromRequest:getHomeRecommendTodayApi];
        NSDictionary *fourImageDataDic = [self parseDataFromRequest:getHomeFourImageApi];
        NSDictionary *expertListDataDic = [self parseDataFromRequest:recommendExpertApi];
        NSDictionary *freeCourseDataDic = [self parseDataFromRequest:getHomeFreeCourseApi];
        NSDictionary *notFreeCourseDataDic = [self parseDataFromRequest:getHomeCourseIsNotFreeApi];
        NSDictionary *FMDataDic = [self parseDataFromRequest:getHomeFmApi];
        NSDictionary *articleDataDic = [self parseDataFromRequest:getArticleApi];
        
        //轮播
        HomeBannerModel *homeBannerModel = [HomeBannerModel yy_modelWithDictionary:bannerDataDic];
        NSArray *bannerItemArray = (NSArray *)homeBannerModel.items;
        NSMutableArray *bannerItemDataArray = [NSMutableArray arrayWithCapacity:bannerItemArray.count];
        for (NSDictionary *bannerItemDic in bannerItemArray) {
            HomeBannerItems *bannerItem = [HomeBannerItems yy_modelWithDictionary:bannerItemDic];
            [bannerItemDataArray addObject:bannerItem];
        }
        _headView.bannerArray = bannerItemDataArray;
        //今日推荐
        
        HomeRecommendTodayModel *recommendTodayModel = [HomeRecommendTodayModel yy_modelWithDictionary:recommendDataDic];
        NSLog(@"recommendTodayObject.article.articleTitle : %@",recommendTodayModel.object.article.articleTitle);
        
        //四块功能图
        
        
        //专栏订阅  推荐专家
        HomeExpertListModel *expertListModel = [HomeExpertListModel yy_modelWithDictionary:expertListDataDic];
        NSArray *expertListItemArray = (NSArray *)expertListModel.items;
        NSMutableArray *expertListItemDataArray = [NSMutableArray arrayWithCapacity:expertListItemArray.count];
        for (NSDictionary *expertListItemDic in expertListItemArray) {
            HomeExpertItems *item = [HomeExpertItems yy_modelWithDictionary:expertListItemDic];
            [expertListItemDataArray addObject:item];
        }
        
        
        //免费课程
        HomeFreeCourseModel *homeFreeCourseModel = [HomeFreeCourseModel yy_modelWithDictionary:freeCourseDataDic];
        NSArray *freeCourseItemArray = (NSArray *)homeFreeCourseModel.items;
        NSMutableArray *freeCourseItemDataArray = [NSMutableArray arrayWithCapacity:freeCourseItemArray.count];
        for (NSDictionary *freeCourseItemDic in freeCourseItemArray) {
            HomeFreeCourseItems *freeCourseItem = [HomeFreeCourseItems yy_modelWithDictionary:freeCourseItemDic];
            [freeCourseItemDataArray addObject:freeCourseItem];
        }
        NSLog(@"freeCourseItemDataArray : %@",freeCourseItemDataArray);
        
        
        //付费课程
        HomeNotFreeCourseModel *homeNotFreeCourseModel = [HomeNotFreeCourseModel yy_modelWithDictionary:notFreeCourseDataDic];
        NSArray *notFreeCourseItemArray = (NSArray *)homeNotFreeCourseModel.items;
        NSMutableArray *notFreeCourseItemDataArray = [NSMutableArray arrayWithCapacity:notFreeCourseItemArray.count];
        for (NSDictionary *notFreeCourseItemDic in notFreeCourseItemArray) {
            HomeNotFreeCourseItems *notFreeCourseItem = [HomeNotFreeCourseItems yy_modelWithDictionary:notFreeCourseItemDic];
            [notFreeCourseItemDataArray addObject:notFreeCourseItem];
        }
        NSLog(@"notFreeCourseItemDataArray : %@",notFreeCourseItemDataArray);
        
        //FM
        HomeFMModel *FMModel = [HomeFMModel yy_modelWithDictionary:FMDataDic];
        NSArray *FMItemArray = (NSArray *)FMModel.items;
        NSMutableArray *FMItemDataArray = [NSMutableArray arrayWithCapacity:FMItemArray.count];
        for (NSDictionary *FMItemDic in FMItemArray) {
            HomeFMItems *FMItem = [HomeFMItems yy_modelWithDictionary:FMItemDic];
            [FMItemDataArray addObject:FMItem];
        }
        NSLog(@"FMItemDataArray : %@",FMItemDataArray);
        
        //美文推荐
        HomeArticleModel *homeArticleModel = [HomeArticleModel yy_modelWithDictionary:articleDataDic];
        NSDictionary *homeArticleItemDic = (NSDictionary *)homeArticleModel.items[0];
        HomeArticleItems *homeArticleItem = [HomeArticleItems yy_modelWithDictionary:homeArticleItemDic];
        
        
        _tableView.homeRecommendTodayModel = recommendTodayModel;
        _tableView.homeExpertListArray = expertListItemDataArray;
        _tableView.homeFreeCourseArray = freeCourseItemDataArray;
        _tableView.homeNotFreeCourseArray = notFreeCourseItemDataArray;
        _tableView.homeFMArray = FMItemDataArray;
        _tableView.homeArticleItem = homeArticleItem;
        [_tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        [self.tableView.mj_header endRefreshing];
    }];
    
}


- (NSDictionary *)parseDataFromRequest:(YTKRequest *)request{
    NSData *data = request.responseData;
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}


@end
