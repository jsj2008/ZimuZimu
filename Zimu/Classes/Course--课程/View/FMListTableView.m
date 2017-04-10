//
//  FMListTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMListTableView.h"
#import "FMListHeaderCell.h"
#import "FMListCell.h"

static NSString *headerIdentifier = @"FMListHeaderCell";
static NSString *FMListIdentifier = @"FMListCell";

@interface FMListTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FMListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        
        [self registerNib:[UINib nibWithNibName:@"FMListHeaderCell" bundle:nil] forCellReuseIdentifier:headerIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMListCell" bundle:nil] forCellReuseIdentifier:FMListIdentifier];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FMListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section == 0) cell.titleString = @"为您推荐";
        else if (indexPath.section == 1) cell.titleString = @"最新精品";
        else cell.titleString = @"热门听单";
        
        return cell;
    }
    FMListCell *cell = [tableView dequeueReusableCellWithIdentifier:FMListIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.section == 0)
        cell.dataArray = @[@"你的名字ddjljdsljfljflsjflsjflsdj",@"我的名字",@"他的名字"];
    else if (indexPath.section == 1)
        cell.dataArray = @[@"你的孩子不会再跟你说话了",@"放弃吧，少年",@"心愿是世界和平",@"我为你赞了半年的积蓄",@"漂洋过海的来看你",@"记忆他总是满满的累积"];
    else cell.dataArray = @[@"我甘愿成全了你珍藏的往昔",@"然后就拖着自己到山城隐居",@"你却在终点等我",@"住进你心里",@"没有你的地方都是他乡",@"没有你的旅行都是流浪"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }else{
        CGFloat height = ((kScreenWidth - 40)/3.0) * 0.75 + 40;
        if (indexPath.section == 0) {
            return height/375.0 * kScreenWidth + 20;
        }
        return (height * 2)/375.0 * kScreenWidth + 30;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


@end
