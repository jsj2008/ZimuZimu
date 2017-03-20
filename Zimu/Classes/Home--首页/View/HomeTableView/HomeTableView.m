//
//  HomeTableView.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeTableView.h"
#import "WindListenCell.h"
#import "RecommendCell.h"
#import "FourSquareCell.h"
#import "SubscibeCell.h"
#import "HeaderTitleCell.h"
#import "VideoCourseCell.h"
#import "FMCell.h"
#import "BookHomeCell.h"

#import "TestViewController.h"
#import "UIView+ViewController.h"
#import "ListenHeartViewController.h"

static NSString *windListenIdentifier = @"windListenCell";
static NSString *recommendCellIdentifier = @"recommendCell";
static NSString *fourSquareIdentifier = @"fourSquareCell";
static NSString *headerTitleIdentifier = @"headerTitleCell";
static NSString *subscribeIdentifier = @"subscribeCell";
static NSString *videoCourseIdentifier = @"videoCourseCell";
static NSString *FMIdentifier = @"FMCell";
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
        
        //注册单元格
        [self registerNib:[UINib nibWithNibName:@"WindListenCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:windListenIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FourSquareCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:fourSquareIdentifier];
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:headerTitleIdentifier];
        [self registerNib:[UINib nibWithNibName:@"SubscibeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:subscribeIdentifier];
        [self registerNib:[UINib nibWithNibName:@"VideoCourseCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:videoCourseIdentifier];
        [self registerNib:[UINib nibWithNibName:@"RecommendCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:recommendCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:FMIdentifier];
        [self registerNib:[UINib nibWithNibName:@"BookHomeCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bookHomeIdentifier];
        
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self sethiddenExtraLine];
    }
    return self;
}

//UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0 || section == 2) {
        return 1;
    }else if (section == 1) {
        return 4;
    }else if (section == 3) {
        return 3;
    }
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WindListenCell *cell = [tableView dequeueReusableCellWithIdentifier:windListenIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
        
        return cell;
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"今日推荐";
            cell.imageString = @"home_jinrituijian_icon";
            cell.moreButton.hidden = YES;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        RecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellIdentifier];
        cell.titleString = @"布满汉字，老外眼中的中国键盘竟是这样的";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 2) {
        FourSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:fourSquareIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 3){
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"专栏订阅";
            cell.imageString = @"home_zhuanlandingyue_icon";
            cell.moreButton.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        SubscibeCell *cell = [tableView dequeueReusableCellWithIdentifier:subscribeIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageString = [NSString stringWithFormat:@"home_zhuanlandingyue%li",indexPath.row];
        
        return cell;
    }else if(indexPath.section == 4){
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"视频课程 | 免费";
            cell.imageString = @"home_mianfeishipin_icon";
            cell.moreButton.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        VideoCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCourseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageArray = @[@"home_course1",@"home_course2",@"home_course3",@"home_course1",@"home_course2",@"home_course3"];
        
        return cell;
    }else if(indexPath.section == 5){
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"视频课程 | 收费";
            cell.imageString = @"home_shoufeishipin_icon";
            cell.moreButton.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        VideoCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCourseIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageArray = @[@"home_video1",@"home_video2",@"home_video3",@"home_video1",@"home_video2",@"home_video3"];
        
        return cell;
    }else if(indexPath.section == 6){
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"心灵FM | 免费";
            cell.imageString = @"home_FM_icon";
            cell.moreButton.hidden = NO;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        FMCell *cell = [tableView dequeueReusableCellWithIdentifier:FMIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageArray = @[@"home_FM1",@"home_FM2",@"home_FM3",@"home_FM1",@"home_FM2",@"home_FM3"];
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.titleString = @"美文推荐";
            cell.imageString = @"home_meiwentuijian_icon";
            cell.moreButton.hidden = NO;
            [cell.moreButton setTitle:@"查看往期" forState:UIControlStateNormal];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
        BookHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:bookHomeIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageString = @"home_ recommend";
        
        return cell;
    }
}

//UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {       //清风倾听
        return 60;
    }else if (indexPath.section == 1) {     //今日推荐
        if (indexPath.row == 0) {
            return 38;
        }else if (indexPath.row == 2){
            return 15;
        }
        
        return 45;
    }else if (indexPath.section == 2) {     //四个模块
        return 190;
    }else if(indexPath.section == 3){       //专栏订阅
        if (indexPath.row == 0) {
            return 38;
        }
        
        return 120;
    }else if(indexPath.section == 4 | indexPath.section == 5){
        if (indexPath.row == 0) {
            return 38;
        }
        return (142/375.0) * kScreenWidth + 20;
    }else if(indexPath.section == 6){
        if (indexPath.row == 0) {
            return 38;
        }
        return (132/375.0) * kScreenWidth + 20;
    }else{
        if (indexPath.row == 0) {
            return 38;
        }
        
        return 110;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section : %li  row : %li",indexPath.section,indexPath.row);
    
    if (indexPath.section == 0) {
        [self.viewController.navigationController pushViewController:[[ListenHeartViewController alloc]init] animated:YES];
    }else{
        TestViewController *testVC = [[TestViewController alloc]init];
        [self.viewController.navigationController pushViewController:testVC animated:YES];
        NSLog(@"viewc : %@",self.viewController);        
    }
    
}



- (void)sethiddenExtraLine{
    UIView *view = [[UIView alloc]init];
    
    self.tableFooterView = view;
}



@end
