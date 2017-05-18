//
//  ActivityTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityTableView.h"
#import "ActivityListCell.h"
#import "UIView+ViewController.h"
#import "ActivityDetailViewController.h"

static NSString *identifier = @"ActivityListCell";

@interface ActivityTableView ()<UITableViewDelegate, UITableViewDataSource>
//{
//    NSArray *_titleArray;
//    NSArray *_priceArray;
//    NSArray *_bgImageArray;
//}

@end


@implementation ActivityTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"ActivityListCell" bundle:nil] forCellReuseIdentifier:identifier];
        
//        _titleArray = @[@"亲子共学团", @"家庭幸福助力成长", @"子慕幸福合伙人计划",@"温柔教养"];
//        _priceArray = @[@"500",@"2680",@"8800",@"12880"];
//        _bgImageArray = @[@"activity_list1",@"activity_list2",@"activity_list3",@"activity_list1"];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _activityListModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.titleString = _titleArray[indexPath.row];
//    cell.priceString = _priceArray[indexPath.row];
//    cell.bgImageString = _bgImageArray[indexPath.row];
    cell.activityListModel = _activityListModelArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityDetailViewController *activityDetailTableView = [[ActivityDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:activityDetailTableView animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 * kScreenWidth / 375.0;
}


- (void)setActivityListModelArray:(NSArray *)activityListModelArray{
    _activityListModelArray = activityListModelArray;
    [self reloadData];
}

@end
