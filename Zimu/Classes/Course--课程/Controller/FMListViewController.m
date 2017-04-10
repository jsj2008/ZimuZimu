//
//  FMListViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMListViewController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "FMListTableView.h"
#import "CourseBannerView.h"

@interface FMListViewController ()

@property (nonatomic, strong) FMListTableView *fmListTableView;

@property (nonatomic, strong) CourseBannerView *headerView;

@end

@implementation FMListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"FM";
    self.view.backgroundColor = themeWhite;
    UIBarButtonItem *fmButtom = [UIBarButtonItem barButtonItemWithImageName:@"course_nav_right" title:@"" target:self action:@selector(FMPlay)];
    self.navigationItem.rightBarButtonItem = fmButtom;
    
    [self.view addSubview:self.fmListTableView];
    
}

- (void)FMPlay{
    NSLog(@"fm播放页");
}


- (FMListTableView *)fmListTableView{
    if (!_fmListTableView) {
        _fmListTableView = [[FMListTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        _fmListTableView.backgroundColor = themeGray;

        _fmListTableView.tableHeaderView = self.headerView;
    }
    return _fmListTableView;
}

- (CourseBannerView *)headerView{
    if (!_headerView) {
        _headerView = [[CourseBannerView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200)];
        _headerView.bannerArray = @[@"http://on9fin031.bkt.clouddn.com/image/20170323174423228187",
                                    @"http://on9fin031.bkt.clouddn.com/image/20170323174653515679",
                                    @"http://on9fin031.bkt.clouddn.com/image/20170323174810211784",
                                    @"http://on9fin031.bkt.clouddn.com/image/20170323174827350730"];
    }
    return _headerView;
}

@end
