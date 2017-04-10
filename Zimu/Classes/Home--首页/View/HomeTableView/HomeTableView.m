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
        return 1 + _homeExpertListArray.count;
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
        if (indexPath.row == 1) {
            cell.titleString = [NSString stringWithFormat:@"文章 | %@",_homeRecommendTodayModel.object.article.articleTitle];
        }else if (indexPath.row == 2){
            cell.titleString = [NSString stringWithFormat:@"FM | %@",_homeRecommendTodayModel.object.fm.fmTitle];
        }else if (indexPath.row == 3){
            cell.titleString = [NSString stringWithFormat:@"视频 | %@",_homeRecommendTodayModel.object.video.videoTitle];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 2) {     //四张图功能
        FourSquareCell *cell = [tableView dequeueReusableCellWithIdentifier:fourSquareIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 3){       //专栏订阅
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
        cell.homeExpretItem = _homeExpertListArray[indexPath.row - 1];
        
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
        cell.homeFreeCourseModelArray = _homeFreeCourseArray;
        
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
        cell.homeNotFreeCourseModelArray = _homeNotFreeCourseArray;
        
        
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
        cell.homeFMModelArray = _homeFMArray;
        
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
//        cell.imageString = @"home_ recommend";
        cell.homeArticleItem = _homeArticleItem;
        
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
        return 60/375.0 * kScreenWidth;
    }else if (indexPath.section == 1) {     //今日推荐
        if (indexPath.row == 0) {
            return 38;
        }else if (indexPath.row == 2){
            return 15;
        }
        return 45;
    }else if (indexPath.section == 2) {     //四个模块
        return 100/375.0 * kScreenWidth;
    }else if(indexPath.section == 3){       //专栏订阅
        if (indexPath.row == 0) {
            return 38;
        }
        return 120;
    }else if(indexPath.section == 4 | indexPath.section == 5){
        if (indexPath.row == 0) {
            return 38;
        }
        return 90/375.0 * kScreenWidth + 37 + 20;
    }else if(indexPath.section == 6){
        if (indexPath.row == 0) {
            return 38;
        }
        return 80/375.0 * kScreenWidth + 37 + 20;
    }else{
        if (indexPath.row == 0) {
            return 38;
        }
        return 110/375.0 * kScreenWidth;
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





@end
