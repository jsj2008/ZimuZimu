//
//  CityCourseDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/13.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseDetailTableView.h"
#import "CityCourseDetailThemeCell.h"
#import "CityCourseDetailThemeCellLayoutFrame.h"
#import "CityCourseDetailInfoCell.h"
#import "CityCourseDetailInfoCellLayoutFrame.h"
#import "CityCourseDetailHeaderCell.h"
#import "FMDetailIntroCell.h"
#import "FMDetailIntroLayoutFrame.h"

#import "CityCourseDetailViewController.h"
#import "UIView+ViewController.h"

static NSString *cityCourseThemeIdentifier = @"CityCourseDetailThemeCell";
static NSString *cityCourseInfoIdentifier = @"CityCourseDetailInfoCell";
static NSString *cityCourseHeaderIdentifier = @"CityCourseDetailHeaderCell";
static NSString *fmIntroCellIdentifier = @"FMDetailIntroCell";


@interface CityCourseDetailTableView ()<UITableViewDelegate, UITableViewDataSource, FMDetailIntroCellDelegate>{
    FMDetailIntroLayoutFrame *_introLayoutFrame;
    BOOL _introCellIsOpening;      //内容cell是否已展开

}

@end
@implementation CityCourseDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"CityCourseDetailThemeCell" bundle:nil] forCellReuseIdentifier:cityCourseThemeIdentifier];
        [self registerNib:[UINib nibWithNibName:@"CityCourseDetailInfoCell" bundle:nil] forCellReuseIdentifier:cityCourseInfoIdentifier];
        [self registerNib:[UINib nibWithNibName:@"CityCourseDetailHeaderCell" bundle:nil] forCellReuseIdentifier:cityCourseHeaderIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailIntroCell" bundle:nil] forCellReuseIdentifier:fmIntroCellIdentifier];

        
    }
    return self;
}


//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return 1;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CityCourseDetailThemeCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCourseThemeIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            CityCourseDetailThemeCellLayoutFrame *layoutFrame = [[CityCourseDetailThemeCellLayoutFrame alloc]initWithThemeString:@"子慕幸福家庭幸福合伙人计划"];
            cell.layoutFrame = layoutFrame;
            cell.backgroundColor = themeGray;
            
            return cell;
        }else{
            CityCourseDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCourseInfoIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            CityCourseDetailInfoCellLayoutFrame *layoutFrame = [[CityCourseDetailInfoCellLayoutFrame alloc]init];
            cell.layoutFrame = layoutFrame;
            
            return cell;
        }
    }else{
        FMDetailIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:fmIntroCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.introLayoutFrame = _introLayoutFrame;
        if (_introCellIsOpening) {
            //已展开
            cell.imageString = @"FM_close";
        }else{
            //未展开
            cell.imageString = @"FM_open";
        }
        
        return cell;
//        if (indexPath.row == 0) {
//        }
    }

}

//delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            CityCourseDetailThemeCellLayoutFrame *layoutFrame = [[CityCourseDetailThemeCellLayoutFrame alloc]initWithThemeString:@"子慕幸福家庭幸福合伙人计划子慕幸福家庭幸福合伙人计划"];
            return layoutFrame.cellHeight;
        }else{
            CityCourseDetailInfoCellLayoutFrame *layoutFrame = [[CityCourseDetailInfoCellLayoutFrame alloc]init];
            return layoutFrame.cellHeight;
        }
    }else{
//        if (indexPath.row == 0) {
//            return 40;
//        }
        _introLayoutFrame = [[FMDetailIntroLayoutFrame alloc]init];
        _introLayoutFrame.isOpening = _introCellIsOpening;
        return _introLayoutFrame.cellHeight;;
    }
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
    
}

#pragma mark - FMDetailIntroCellDelegate
- (void)openCellContentLayout{
    _introCellIsOpening = !_introCellIsOpening;
    [self reloadData];
}


@end
