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
#import <WebKit/WebKit.h>

@interface ActivityDetailViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) ActivityDetailTableView *activityDetailTableView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *applyButton;        //立即报名

@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"亲子共学团";
    self.view.backgroundColor = themeGray;
    
    [self setupActivityDetailTableView];
    [self setupWebView];
    [self setupApplyButton];

    
}
- (void)dealloc{
    //在页面消失时，解除代理，加载空网页，停止加载，清空缓存，释放webview
    //销毁的时候别忘移除监听
    [self.webView.scrollView removeObserver:self forKeyPath:@"contentSize"];
    _webView.delegate = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    _webView = nil;
    
}


#pragma mark - 创建一键报名按钮
- (void)setupApplyButton{
    _applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _applyButton.frame = CGRectMake(0, kScreenHeight - 64 - 49, kScreenWidth, 49);
    [_applyButton setBackgroundColor:themeYellow];
    [_applyButton setTitle:@"立即报名" forState:UIControlStateNormal];
    [_applyButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _applyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_applyButton addTarget:self action:@selector(applyActivity) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_applyButton];
}

- (void)applyActivity{
    NSLog(@"报名成功");
}

#pragma mark - 创建activityDetailTableView
- (void)setupActivityDetailTableView{
    _activityDetailTableView = [[ActivityDetailTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    [self.view addSubview:_activityDetailTableView];
}

#pragma mark - webView图文详情
- (void)setupWebView{
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    _webView.backgroundColor = themeGray;
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    int cacheSizeMemory = 1*1024*1024;
    int cacheSizeDisk = 5*1024*1024;
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:cacheSizeMemory diskCapacity:cacheSizeDisk diskPath:@"nsurlcache"];
    [NSURLCache setSharedURLCache:sharedCache];
    
    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]]];
    
    self.activityDetailTableView.tableFooterView = _webView;
    
    //使用kvo为webView添加监听，监听webView的内容高度
    [self.webView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

//实时改变webView的控件高度，使其高度跟内容高度一致
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect frame = self.webView.frame;
        frame.size.height = self.webView.scrollView.contentSize.height;
        self.webView.frame = frame;
                
        self.activityDetailTableView.tableFooterView = self.webView;
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"WebKitCacheModelPreferenceKey"];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitDiskImageCacheEnabled"];//图片缓存
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"WebKitOfflineWebApplicationCacheEnabled"];//自己添加的，原文没有提到。
    [[NSUserDefaults standardUserDefaults] synchronize];
}


@end
