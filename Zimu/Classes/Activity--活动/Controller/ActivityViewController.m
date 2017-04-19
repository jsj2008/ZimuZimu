//
//  ActivityViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityViewController.h"
#import "UIImage+ZMExtension.h"
#import "ActivityTableView.h"

@interface ActivityViewController ()

@property (nonatomic, strong) ActivityTableView *activityTableView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"活动报名";
    self.view.backgroundColor = themeWhite;
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIColor *naviColor = [UIColor colorWithHexString:@"f5ce13"];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:naviColor size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    /*创建activityTableView*/
    [self setupActivityTableView];
}

/**
 *  activityTableView
 */
- (void)setupActivityTableView{
    _activityTableView = [[ActivityTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_activityTableView];
}



@end
