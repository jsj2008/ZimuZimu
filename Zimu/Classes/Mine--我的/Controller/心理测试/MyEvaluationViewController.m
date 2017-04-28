//
//  MyEvaluationViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyEvaluationViewController.h"
#import "EvaluationListTableView.h"
#import "UIImage+ZMExtension.h"

@interface MyEvaluationViewController ()

@property (nonatomic, strong) EvaluationListTableView *evaluationListTableView;

@end

@implementation MyEvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的心理测试";
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    self.view.backgroundColor = themeWhite;
    
    [self setupEvaluationListTableView];
    
}

/**
 *  evaluationListTableView
 */
- (void)setupEvaluationListTableView{
    _evaluationListTableView = [[EvaluationListTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_evaluationListTableView];
}

@end
