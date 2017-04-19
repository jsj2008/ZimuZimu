//
//  ArticleViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ArticleViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>

static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface ArticleViewController ()<UIScrollViewDelegate, WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
/*加载进度条*/
@property (nonatomic, strong) UIProgressView *progressView;
/*加载的URL*/
@property (nonatomic, copy) NSString *URLString;


@end


@implementation ArticleViewController

- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _articleTitle;
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //加载web页面
    [self startLoadWebView];
    
    //添加到主控制器上
    [self.view addSubview:self.wkWebView];
    
    //添加进度条
    [self.view addSubview:self.progressView];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.wkWebView.navigationDelegate = nil;
    self.wkWebView.UIDelegate = nil;
}

/**
 *  开始加载web页面
 */
- (void)startLoadWebView{
    //创建一个NSURLRequest对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    //加载网页
    [self.wkWebView loadRequest:request];
    
}

/**
 *  wkWebView
 */
- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //网页的配置文件
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
        //允许与网页交互，选择视图
        configuration.selectionGranularity = YES;
        //是否支持记忆读取
        configuration.suppressesIncrementalRendering = YES;
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) configuration:configuration];
        _wkWebView.backgroundColor = [UIColor clearColor];
        //设置代理
        _wkWebView.scrollView.delegate = self;
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        //kvo添加进度条监听
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:WkwebBrowserContext];
        //手势
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

/**
 *  progressView
 */
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 0, kScreenWidth, 5);
        //进度值
        [_progressView setTrackTintColor:themeGreen];
        [_progressView setTintColor:themeGreen];
        
    }
    return _progressView;
}


#pragma mark - WKNavigationDelegate
//开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载时，进度条显示
    self.progressView.hidden = NO;
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载超时");
}



#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    if (y >= 100) {
        self.title = _wkWebView.title;
    }else{
        self.title = nil;
    }
}


//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)loadWebURLSring:(NSString *)string{
    self.URLString = string;
}

@end
