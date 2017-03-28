//
//  SubscribedExpertTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribedExpertTableViewController.h"
#import "SubscribedExpertCell.h"
#import "SubscribeDetailViewController.h"

static NSString *subscribedExpertIdentifier = @"subscribedExpertCell";
@interface SubscribedExpertTableViewController ()

@end

@implementation SubscribedExpertTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"SubscribedExpertCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:subscribedExpertIdentifier];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubscribedExpertCell *cell = [tableView dequeueReusableCellWithIdentifier:subscribedExpertIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageString = @"home_zhuanlandingyue1";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.navigationController pushViewController:[[SubscribeDetailViewController alloc]init] animated:YES];
}



@end
