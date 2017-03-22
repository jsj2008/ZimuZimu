//
//  FindViewController.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindViewController.h"
#import "FindListTableView.h"

@interface FindViewController ()

@end

@implementation FindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self makeTableView];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)makeTableView{
    FindListTableView *tableView = [[FindListTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 0) style:UITableViewStylePlain];
    
    [self.view addSubview:tableView];
}
@end
