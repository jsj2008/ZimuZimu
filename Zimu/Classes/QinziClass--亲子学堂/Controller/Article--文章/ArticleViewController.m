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
#import "GetArticleByPrimaryKeyApi.h"
#import "ArticleDetailModel.h"
#import "MBProgressHUD+MJ.h"
#import "CommentBar.h"
#import "UIView+SnailUse.h"
#import "ArticleTableView.h"
#import "GetArticleCommentListApi.h"
#import "InsertArticleCommentApi.h"
#import "CommentModel.h"
#import "InsertArticleCollectionApi.h"
#import "GetWhetherFavoriteArticleApi.h"
#import "InsertCollectionModel.h"
#import "NewLoginViewController.h"
#import "ZMBlankView.h"
#import "ZMShareManager.h"
#import <UShareUI/UShareUI.h>

static void *WkwebBrowserContext = &WkwebBrowserContext;

@interface ArticleViewController ()<WKUIDelegate, WKNavigationDelegate, CommentBarDelegate, LoginViewControllerDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
/*加载进度条*/
@property (nonatomic, strong) UIProgressView *progressView;
/*加载的URL*/
@property (nonatomic, copy) NSString *URLString;
/*评论*/
@property (nonatomic, strong) ArticleTableView *articleTableView;
/*评论栏*/
@property (nonatomic, strong) CommentBar *commentBar;
@property (nonatomic, strong) NSMutableArray *commentModelArray;

@end


@implementation ArticleViewController

- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
    [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentSize"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _articleTitle;
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //文章URL地址
    [self loadWebURLSring:_articleID];
    
    //加载web页面
    [self startLoadWebView];
    
    //添加到主控制器上
    [self.view addSubview:self.wkWebView];
    
    [self setupArticleTableView];
    [self setupCommentBar];
    //添加进度条
    [self.view addSubview:self.progressView];
    
    //获取评论数据
    [self getArticleCommentData];
    
    //判断是否登录
    NSString *token = userToken;
    if (token.length != 0) {
        //登录
        [self checkWhetherSelectArticle];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.wkWebView.navigationDelegate = nil;
    self.wkWebView.UIDelegate = nil;
}

/*评论栏*/
- (void)setupCommentBar{
    _commentBar = [UIView commentBar];
    _commentBar.delegate = self;
    [self.view addSubview:_commentBar];
}
#pragma mark - CommentBarDelegate
//分享
- (void)commentBarShare{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        NSLog(@"%zd --- %@", platformType, userInfo);
        ZMShareManager *shreMgr = [[ZMShareManager alloc] init];
        [shreMgr shareWebPageToPlatformType:platformType thumbImg:[UIImage imageNamed:@"AppIcon"] webLink:self.URLString title:_articleTitle descr:@"子慕亲子--中国专业的亲子心理教育平台"];
    }];

}
//收藏
- (void)commentBarSelect:(UIButton *)button{
    //判断是否登录
    if ([userToken isEqualToString:@"logout"]) {
        //去登录
        [self gotoLogin];
    }else{
        //收藏
        button.selected = !button.selected;
        [self collectArticle];
    }
}
//评论
- (void)commentBarComment{
    [_articleTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
//发表评论
- (void)commentBarSubmit:(NSString *)text{
    //判断是否登录
    if ([userToken isEqualToString:@"logout"]) {
        //去登录
        [self gotoLogin];
    }else{
        //发表评论
        [self insertArticleCommentDataWithText:text];
    }
}


/*评论列表*/
- (void)setupArticleTableView{
    _articleTableView = [[ArticleTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    _articleTableView.tableHeaderView = self.wkWebView;
    [self.view addSubview:_articleTableView];
}

//#pragma mark - 获取文章数据
//- (void)getArticleDetailData{
//    GetArticleByPrimaryKeyApi *getArticleByPrimaryKeyApi = [[GetArticleByPrimaryKeyApi alloc]initWithArticleId:_articleID];
//    [getArticleByPrimaryKeyApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
//        NSData *data = request.responseData;
//        NSError *error = nil;
//        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
//        if (error) {
//            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
//            return ;
//        }
//        ArticleDetailModel *articleDetailModel = [ArticleDetailModel yy_modelWithDictionary:dataDic];
//        if (!articleDetailModel.isTrue) {
//            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
//            return;
//        }
//        
//    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
//        [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
//    }];
//}



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
        _wkWebView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) configuration:configuration];
        _wkWebView.backgroundColor = [UIColor clearColor];
        //设置代理
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        //使用kvo为webView添加监听，监听webView的内容高度
        [_wkWebView.scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
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
    }else if ([keyPath isEqualToString:@"contentSize"]) {
        CGRect frame = self.wkWebView.frame;
        frame.size.height = self.wkWebView.scrollView.contentSize.height;
        self.wkWebView.frame = frame;
        _articleTableView.tableHeaderView = self.wkWebView;
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (void)loadWebURLSring:(NSString *)string{
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];

    self.URLString = [NSString stringWithFormat:@"%@zimu_portal/html/share/shareArticle.html?articleId=%@", config.baseUrl,string];
}


#pragma mark - 获取评论数据
- (void)getArticleCommentData{
    GetArticleCommentListApi *getArticleCommentListApi = [[GetArticleCommentListApi alloc]initWithArticleId:_articleID];
    [getArticleCommentListApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:@"暂无评论数据" toView:self.view];
            return;
        }
        NSArray *dataArray = dataDic[@"items"];
        if (_commentModelArray) {
            [_commentModelArray removeAllObjects];
            _commentModelArray = nil;
        }
        _commentModelArray = [NSMutableArray array];
        if (dataArray.count) {
            for (NSDictionary *dic in dataArray) {
                CommentModel *commentModel = [CommentModel yy_modelWithDictionary:dic];
                [_commentModelArray addObject:commentModel];
            }
        }
        _articleTableView.articleCommentModelArray = _commentModelArray;
        
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netTimeOut];
            
        }
    }];
}

#pragma mark - 插入评论数据
- (void)insertArticleCommentDataWithText:(NSString *)text{
    InsertArticleCommentApi *insertArticleCommentApi = [[InsertArticleCommentApi alloc]initWithArticleId:_articleID commentVal:text];
    [insertArticleCommentApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"评论失败" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.0];
            return;
        }
        [MBProgressHUD showMessage_WithoutImage:@"发表成功" toView:self.view];
        _commentBar.textField.text = @"";
        [_commentBar.textField resignFirstResponder];
        [self refreshCommentData];
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"评论失败" toView:self.view];
    }];
    
}

//刷新数据
- (void)refreshCommentData{
    [self getArticleCommentData];
}


#pragma mark - 查询是否已收藏文章
- (void)checkWhetherSelectArticle{
    GetWhetherFavoriteArticleApi *getWhetherFavoriteArticleApi = [[GetWhetherFavoriteArticleApi alloc]initWithArticleId:_articleID];
    [getWhetherFavoriteArticleApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (isTrue) {
            //已收藏
            _commentBar.hasCollected = YES;
            
        }else{
            //未收藏
            _commentBar.hasCollected = NO;
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netTimeOut];
            
        }
    }];
}

#pragma mark - 收藏文章
- (void)collectArticle{
    //保存初始收藏状态
    BOOL hasCollected = _commentBar.hasCollected;
    InsertArticleCollectionApi *insertArticleCollectionApi = [[InsertArticleCollectionApi alloc]initWithArticleId:_articleID];
    [insertArticleCollectionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            _commentBar.hasCollected = hasCollected;        //不改变收藏状态
            [MBProgressHUD showMessage_WithoutImage:@"数据异常，请稍后再试" toView:self.view];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            _commentBar.hasCollected = hasCollected;        //不改变收藏状态
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:self.view];
            [self performSelector:@selector(gotoLogin) withObject:nil afterDelay:1.0];
            return;
        }
        
        InsertCollectionModel *model = [InsertCollectionModel yy_modelWithDictionary:dataDic[@"object"]];
        NSInteger status = [model.status integerValue];
        if (status) {
            //收藏成功
            [MBProgressHUD showMessage_WithoutImage:@"收藏成功" toView:self.view];
            _commentBar.hasCollected = YES;
        }else{
            //取消收藏成功
            [MBProgressHUD showMessage_WithoutImage:@"取消收藏" toView:self.view];
            _commentBar.hasCollected = NO;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        _commentBar.hasCollected = hasCollected;        //不改变收藏状态
        NSError *error = request.error;
        NSInteger errorCode = error.code;
        NSLog(@"errorcode : %li",errorCode);
        if (errorCode == -1009) {
            [self noNet];
            
        }
        //请求超时
        else if (errorCode == -1001) {
            [self netTimeOut];
            
        }
        //其他原因
        else {
            [self netTimeOut];
            
        }
    }];
}


#pragma mark - 去登陆
- (void)gotoLogin{
    NewLoginViewController *newLoginVC = [[NewLoginViewController alloc]init];
    newLoginVC.delegate = self;
    [self presentViewController:newLoginVC animated:YES completion:nil];
}
//LoginViewControllerDelegate
- (void)loginSuccess{
    [self checkWhetherSelectArticle];
}

#pragma mark - 空白页
- (void)noNet{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeNoNet afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getArticleCommentData];
        [self checkWhetherSelectArticle];
        [self startLoadWebView];
    }];
    [self.view addSubview:blankview];
}

- (void)netTimeOut{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeTimeOut afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getArticleCommentData];
        [self checkWhetherSelectArticle];
        [self startLoadWebView];
    }];
    [self.view addSubview:blankview];
}

- (void)netLostServer{
    ZMBlankView *blankview = [[ZMBlankView alloc] initWithFrame:self.view.bounds Type:ZMBlankTypeLostSever afterClickDestory:YES btnClick:^(ZMBlankView *blView) {
        [self getArticleCommentData];
        [self checkWhetherSelectArticle];
        [self startLoadWebView];
    }];
    [self.view addSubview:blankview];
}


@end
