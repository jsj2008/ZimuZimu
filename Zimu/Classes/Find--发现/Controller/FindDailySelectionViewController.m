//
//  FindDailySelectionViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindDailySelectionViewController.h"
#import "UIImage+ZMExtension.h"
#import "FindDailyTableView.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "FindPastSelectionViewController.h"

@interface FindDailySelectionViewController ()

@property (nonatomic, strong) FindDailyTableView *findDailyTableView;

@end

@implementation FindDailySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    self.title = @"每日精选";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"F1C40F"] size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    //往期精选
    UIBarButtonItem *rightBarButtonItem = [UIBarButtonItem barButtonItemWithImageName:@"" title:@"往期精选" target:self action:@selector(pastSelection)];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
    
    [self setupFindTableView];
}

- (void)pastSelection{
    FindPastSelectionViewController *pastSelectionVC = [[FindPastSelectionViewController alloc]init];
    [self.navigationController pushViewController:pastSelectionVC animated:YES];
}

/**
 *  FindTableView
 */
- (void)setupFindTableView{
    _findDailyTableView = [[FindDailyTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    [self.view addSubview:_findDailyTableView];
}

@end
