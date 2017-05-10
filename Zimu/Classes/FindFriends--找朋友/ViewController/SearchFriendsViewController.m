//
//  SearchFriendsViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendsViewController.h"
#import "SearchFriendsListView.h"

@interface SearchFriendsViewController ()

@end

@implementation SearchFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查找朋友";
    
    [self makeUI];
    // Do any additional setup after loading the view.
}

#pragma mark - UI
- (void)makeUI{
    SearchFriendsListView *listView = [[SearchFriendsListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    
    [self.view addSubview:listView];
}



@end
