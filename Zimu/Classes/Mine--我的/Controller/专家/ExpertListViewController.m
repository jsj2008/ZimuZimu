//
//  ExpertListViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertListViewController.h"
#import "ExpertListTableView.h"

@interface ExpertListViewController ()

@property (nonatomic, strong) ExpertListTableView *expertListTableView;

@end

@implementation ExpertListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"心理专家";
    self.view.backgroundColor = themeWhite;
    
    [self setupExpertListTableView];
    
}

/**
 *  expertListTableView
 */
- (void)setupExpertListTableView{
    _expertListTableView = [[ExpertListTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _expertListTableView.backgroundColor = themeGray;
    [self.view addSubview:_expertListTableView];
}

@end
