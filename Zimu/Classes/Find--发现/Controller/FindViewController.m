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

@interface FindViewController ()

@property (nonatomic, strong) FindTableView *findTableView;

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    self.title = @"发现更多";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:_naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //创建findTableView
    [self setupFindTableView];
}


/**
 *  FindTableView
 */
- (void)setupFindTableView{
    _findTableView = [[FindTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_findTableView];
}



@end
