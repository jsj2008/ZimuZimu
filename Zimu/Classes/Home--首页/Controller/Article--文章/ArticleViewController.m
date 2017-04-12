//
//  ArticleViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ArticleViewController.h"

@interface ArticleViewController ()

//@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _articleTitle;
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupWebView];
    
}

- (void)setupWebView{
    UIWebView *webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
    webView.backgroundColor = themeWhite;
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString: @"http://mp.weixin.qq.com/s/WFlfD_GgedmXzlGvx3maxw"]];
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

@end
