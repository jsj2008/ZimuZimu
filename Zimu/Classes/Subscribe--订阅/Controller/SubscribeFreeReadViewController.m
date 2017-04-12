//
//  SubscribeFreeReadViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeFreeReadViewController.h"
#import "SubscribeFreeReadListView.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "UIImage+ZMExtension.h"

@interface SubscribeFreeReadViewController ()

@property (nonatomic, strong) SubscribeFreeReadListView *tableView;

@end

@implementation SubscribeFreeReadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeTableView];
    self.title = @"吴东辉";
    [self makeNavRightBtn];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.shadowImage = [UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:themeWhite size:CGSizeMake(kScreenWidth, 0)] forBarMetrics:UIBarMetricsDefault];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)makeTableView{
    if (!_tableView) {
        _tableView = [[SubscribeFreeReadListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
    }
}
- (void)makeNavRightBtn{
    UIBarButtonItem *searchBtn = [UIBarButtonItem barButtonItemWithImageName:@"course_nav_right" title:@"" target:self action:@selector(fm)];
    self.navigationItem.rightBarButtonItem = searchBtn;
}
- (void)fm{
    NSLog(@"fm点击");
}
@end
