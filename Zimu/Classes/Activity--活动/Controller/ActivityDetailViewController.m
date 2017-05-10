//
//  ActivityDetailViewController.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailTableView.h"
#import <MJRefresh.h>

@interface ActivityDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIScrollView *botScrollView;
@property (nonatomic, strong) ActivityDetailTableView *activityDetailTableView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) UIButton *applyButton;        //一键报名

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _height = kScreenHeight - 64 - 49;
    self.title = @"亲子共学团";
    self.view.backgroundColor = themeGray;
    
    [self setupBotScrollView];
    [self setupActivityDetailTableView];
    [self setupWebView];
    [self setupApplyButton];
    
    //设置上拉与下拉
    [self setProductDetailTableViewFooter];
    [self setWebViewHeader];
    
}
- (void)dealloc{
    //在页面消失时，解除代理，加载空网页，停止加载，清空缓存，释放webview
    _webView.delegate = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

- (void)viewWillAppear:(BOOL)animated{
    [self.botScrollView addSubview:self.webView];
}


#pragma mark - 创建一键报名按钮
- (void)setupApplyButton{
    _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _applyButton.frame = CGRectMake(0, kScreenHeight - 64 - 49, kScreenWidth, 49);
    [_applyButton setBackgroundColor:themeYellow];
    [_applyButton setTitle:@"一键报名" forState:UIControlStateNormal];
    [_applyButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _applyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_applyButton addTarget:self action:@selector(applyActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applyButton];
}

- (void)applyActivity{
    NSLog(@"报名成功");
}


#pragma mark - 创建底层scrollView
- (void)setupBotScrollView{
    _botScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _height)];
    _botScrollView.contentSize = CGSizeMake(kScreenWidth, _height * 2);
    _botScrollView.contentOffset = CGPointMake(0, 0);
    _botScrollView.pagingEnabled = YES;
    _botScrollView.scrollEnabled = NO;
    _botScrollView.backgroundColor = themeGray;
    [self.view addSubview:_botScrollView];
}

#pragma mark - 创建activityDetailTableView
- (void)setupActivityDetailTableView{
    _activityDetailTableView = [[ActivityDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, _height) style:UITableViewStylePlain];
    [_botScrollView addSubview:_activityDetailTableView];
}

#pragma mark - webView图文详情
- (void)setupWebView{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, _height, kScreenWidth, _height)];
    _webView.backgroundColor = themeGray;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    int cacheSizeMemory = 1*1024*1024;
    int cacheSizeDisk = 5*1024*1024;
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    [_botScrollView addSubview:_webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//图片缓存
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - 设置_activityDetailTableView的上拉加载和webView的下拉加载
- (void)setProductDetailTableViewFooter{
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshAction:)];
    footer.gifView.hidden = YES;
    [footer setBackgroundColor:themeGray];
    [footer setTitle:@"继续拖动，查看图文详情" forState:MJRefreshStateIdle];       /** 普通闲置状态 */
    [footer setTitle:@"释放，即可查看图文详情" forState:MJRefreshStatePulling];    /** 松开就可以进行刷新的状态 */
    [footer setTitle:@"马上为您呈现" forState:MJRefreshStateRefreshing]; /** 正在刷新中的状态 */
    
    _activityDetailTableView.mj_footer = footer;
    
}
- (void)footerRefreshAction:(MJRefreshBackGifFooter *)footer{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _botScrollView.contentOffset = CGPointMake(0, _height);
        _activityDetailTableView.frame = CGRectMake(0, 0, kScreenWidth, _height);
    } completion:^(BOOL finished) {
        [footer endRefreshing];
        [_activityDetailTableView.mj_footer setState:MJRefreshStateIdle];
    }];

}
- (void)setWebViewHeader{
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshAction:)];
    header.gifView.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    [header setBackgroundColor:themeGray];
    [header setTitle:@"下拉，查看活动简介" forState:MJRefreshStateIdle];
    [header setTitle:@"释放，即可查看活动简介" forState:MJRefreshStatePulling];
    [header setTitle:@"马上为您呈现" forState:MJRefreshStateRefreshing];
    
    _webView.scrollView.mj_header = header;
}
- (void)headerRefreshAction:(MJRefreshGifHeader *)header{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        _botScrollView.contentOffset = CGPointMake(0, 0);
    } completion:^(BOOL finished) {
        [header endRefreshing];
        [_webView.scrollView.mj_header setState:MJRefreshStateIdle];
    }];
}

@end
