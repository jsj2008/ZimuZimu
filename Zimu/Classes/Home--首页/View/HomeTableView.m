//
//  HomeTableView.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeTableView.h"
#import "TestViewController.h"
#import "UIView+ViewController.h"
#import "FourSquareCell.h"
#import "HeaderTitleCell.h"
#import "VideoCourseCell.h"
#import "FMHomeListCell.h"
#import "BookHomeCell.h"

static NSString *fourSquareIdentifier = @"fourSquareCell";
static NSString *headerTitleIdentifier = @"headerTitleCell";
static NSString *videoCourseIdentifier = @"videoCourseCell";
static NSString *FMHomeListIdentifier = @"FMHomeListCell";
static NSString *bookHomeIdentifier = @"bookHomeCell";

@interface HomeTableView ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation HomeTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {        
        
        self.backgroundColor = themeGray;
        
        self.dataSource = self;
        self.delegate = self;
        
        [self registerNib:[UINib nibWithNibName:@"FourSquareCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:fourSquareIdentifier];
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:headerTitleIdentifier];
        [self registerNib:[UINib nibWithNibName:@"VideoCourseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:videoCourseIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMHomeListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:FMHomeListIdentifier];
        [self registerNib:[UINib nibWithNibName:@"BookHomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bookHomeIdentifier];
        
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self sethiddenExtraLine];
    }
    return self;
}

//UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 2) {
        return 5;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FourSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:fourSquareIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"视频课程 | 免费";
            cell.moreButton.hidden = NO;
            cell.arrowImageView.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        VideoCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCourseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        
        return cell;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"心灵FM | 免费";
            cell.moreButton.hidden = YES;
            cell.arrowImageView.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        FMHomeListCell *cell = [tableView dequeueReusableCellWithIdentifier:FMHomeListIdentifier];
        cell.titleString = @"布满汉子，老外眼中的中国键盘竟是这样的";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"每日荐书";
            cell.moreButton.hidden = NO;
            cell.arrowImageView.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        BookHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:bookHomeIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    //    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_identifier];
    //    if (cell == nil) {
    //        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:_identifier];
    //    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    self.homeTableViewCellBlock(cell, self.dataArray[indexPath.row]);
    
}

//UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 200;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 40;
        }
        
        return 150;
    }else if(indexPath.section == 2){
        if (indexPath.row == 0) {
            return 40;
        }
        
        return 30;
    }else{
        if (indexPath.row == 0) {
            return 40;
        }
        
        return 110;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section : %li  row : %li",indexPath.section,indexPath.row);
    
    TestViewController *testVC = [[TestViewController alloc]init];
    [self.viewController.navigationController pushViewController:testVC animated:YES];
    NSLog(@"viewc : %@",self.viewController);
}



- (void)sethiddenExtraLine{
    UIView *view = [[UIView alloc]init];
    
    self.tableFooterView = view;
}



@end
