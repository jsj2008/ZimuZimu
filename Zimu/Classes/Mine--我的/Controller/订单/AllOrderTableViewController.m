//
//  AllOrderTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AllOrderTableViewController.h"
#import "NotPayOrderCell.h"
#import "CompleteOrderCell.h"
#import "OrderDetailViewController.h"

static NSString *notPayIdentifier = @"NotPayOrderCell";
static NSString *completeIdentifier = @"CompleteOrderCell";

@interface AllOrderTableViewController ()

@end

@implementation AllOrderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NotPayOrderCell" bundle:nil] forCellReuseIdentifier:notPayIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompleteOrderCell" bundle:nil] forCellReuseIdentifier:completeIdentifier];

    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 5) {
        CompleteOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:completeIdentifier forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    NotPayOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:notPayIdentifier forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 9) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderDetailViewController *orderDetailVC = [[OrderDetailViewController alloc]init];
    [self.navigationController pushViewController:orderDetailVC animated:YES];
}



@end
