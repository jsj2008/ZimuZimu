//
//  CityCourseTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseTableView.h"
#import "CityCourseHeaderCell.h"
#import "CityCourseCell.h"
#import "CityCourseDetailViewController.h"
#import "UIView+ViewController.h"

static NSString *cityCourseHeaderIdentifier = @"CityCourseHeaderCell";
static NSString *cityCourseIdentifier = @"CityCourseCell";

@interface CityCourseTableView ()<UITableViewDelegate, UITableViewDataSource>{
    NSArray *_headerTitles;
}

@end
@implementation CityCourseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"CityCourseHeaderCell" bundle:nil] forCellReuseIdentifier:cityCourseHeaderIdentifier];
        [self registerNib:[UINib nibWithNibName:@"CityCourseCell" bundle:nil] forCellReuseIdentifier:cityCourseIdentifier];
        
        _headerTitles = @[@"离你最近",@"近期举办",@"猜你喜欢"];
        
    }
    return self;
}


//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _headerTitles.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 5;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CityCourseHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCourseHeaderIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 1, 10, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.titleString = _headerTitles[indexPath.section];
        
        return cell;
    }else{
        CityCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCourseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 1, 10, 0, 0);
        
        CityCourseCellLayoutFrame *layoutFrame = [[CityCourseCellLayoutFrame alloc]init];
        cell.layoutFrame = layoutFrame;
        
        return cell;
    }
    
}

//delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }
    CityCourseCellLayoutFrame *layoutFrame = [[CityCourseCellLayoutFrame alloc]init];
    return layoutFrame.cellHeight;
//    return kScreenWidth * 0.4 + 65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];

    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CityCourseDetailViewController *cityCourseDetailVC = [[CityCourseDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:cityCourseDetailVC animated:YES];
}


@end
