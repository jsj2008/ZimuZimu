//
//  ActivityDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityDetailTableView.h"
#import "ActivityHeaderCell.h"
#import "ActivityProgressCell.h"
#import "ActivityChooseCell.h"
#import "UIView+ViewController.h"

static NSString *headerIdentifier = @"ActivityHeaderCell";
static NSString *progressIdentifier = @"ActivityProgressCell";
static NSString *chooseIdentifier = @"ActivityChooseCell";
static NSString *webHeaderIdentifier = @"webNormalCell";

@interface ActivityDetailTableView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ActivityDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[ActivityHeaderCell class] forCellReuseIdentifier:headerIdentifier];
        [self registerClass:[ActivityProgressCell class] forCellReuseIdentifier:progressIdentifier];
        [self registerClass:[ActivityChooseCell class] forCellReuseIdentifier:chooseIdentifier];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:webHeaderIdentifier];
        
        _isSelectAddress = NO;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_isSelectAddress) {
        return 4;
    }
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ActivityHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        if (_isSelectAddress) {
            if(indexPath.section == 1){
                ActivityProgressCell*cell = [tableView dequeueReusableCellWithIdentifier:progressIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
                return cell;
            }else if(indexPath.section == 2){
                ActivityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"请选择课程";
                cell.contentLabel.text = _addressString;
                
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:webHeaderIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"课程详情";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
                
                return cell;
            }
        }else{
            if (indexPath.section == 1) {
                ActivityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:chooseIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.titleLabel.text = @"请选择课程";
                cell.contentLabel.text = @"未选择";
                
                return cell;
            }else{
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:webHeaderIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.text = @"课程详情";
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.textLabel.textColor = [UIColor colorWithHexString:@"333333"];
                
                return cell;
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 345 * kScreenWidth/375.0 + 75;
    }else{
        if (_isSelectAddress) {
            if(indexPath.section == 1){
                return 130;
            }else{
                return 40;
            }
        }else{
            return 40;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_isSelectAddress) {
        if (section == 3) {
            return CGFLOAT_MIN;
        }
    }else{
        if (section == 2) {
            return CGFLOAT_MIN;
        }
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isSelectAddress) {     //已选择过地址
        if (indexPath.section == 2) {
            [self.detailDelegate activityDetailTableViewDidSelect];
        }
    }else{
        if (indexPath.section == 1) {
            [self.detailDelegate activityDetailTableViewDidSelect];
        }
    }
}



- (void)setIsSelectAddress:(BOOL)isSelectAddress{
    if ((_isSelectAddress != isSelectAddress)) {
        _isSelectAddress = isSelectAddress;
        [self reloadData];
    }
}

- (void)setAddressString:(NSString *)addressString{
    if (_addressString != addressString) {
        _addressString = addressString;
        ActivityChooseCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
        cell.contentLabel.text = addressString;
    }
}

- (void)setActivityCategoryInfoModel:(ActivityCategoryInfoModel *)activityCategoryInfoModel{
    if (_activityCategoryInfoModel != activityCategoryInfoModel) {
        _activityCategoryInfoModel = activityCategoryInfoModel;
        
        ActivityHeaderCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cell.activityCategoryInfoModel = activityCategoryInfoModel;
    }
}

- (void)setActivityCourseModel:(ActivityCourseModel *)activityCourseModel{
    ActivityProgressCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.activityCourseModel = activityCourseModel;
}

- (void)setCoursePrice:(NSString *)coursePrice{
    ActivityHeaderCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.coursePrice = coursePrice;
}


@end
