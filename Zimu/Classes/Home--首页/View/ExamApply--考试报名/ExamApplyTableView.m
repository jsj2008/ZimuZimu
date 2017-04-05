//
//  ExamApplyTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExamApplyTableView.h"
#import "EntranceCell.h"
#import "ExamSectionHeaderCell.h"
#import "ExamAnswerCell.h"
#import "ExamFreeVideoCell.h"
#import "ExamFreeFMCell.h"

static NSString *entranceIdentifier = @"entranceCell";
static NSString *examSectionHeaderIdentifier = @"examSectionHeaderCell";
static NSString *examAnswerIdentifier = @"examAnswerCell";
static NSString *examFreeVideoIdentifier = @"examFreeVideoCell";
static NSString *examFreeFMIdentifier = @"examFreeFMCell";

@interface ExamApplyTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ExamApplyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
//        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"entranceCell"];
        [self registerNib:[UINib nibWithNibName:@"EntranceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:entranceIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ExamSectionHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:examSectionHeaderIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ExamAnswerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:examAnswerIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ExamFreeVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:examFreeVideoIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ExamFreeFMCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:examFreeFMIdentifier];

    }
    return self;
}

//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 5;
    }else if (section == 2){
        return 2;
    }else{
        return 2;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        EntranceCell *cell = [tableView dequeueReusableCellWithIdentifier:entranceIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            ExamSectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:examSectionHeaderIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"试题解答 | 免费";
            
            return cell;
        }
        ExamAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:examAnswerIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            ExamSectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:examSectionHeaderIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"考试视频 | 免费";
            
            return cell;
        }
        ExamFreeVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:examFreeVideoIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageArray = @[@"home_course1",@"home_course2",@"home_course3",@"home_FM1"];
        
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            ExamSectionHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:examSectionHeaderIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"FM课程 | 免费";
            
            return cell;
        }
        ExamFreeFMCell *cell = [tableView dequeueReusableCellWithIdentifier:examFreeFMIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageString = [NSString stringWithFormat:@"home_FM%li",indexPath.row];
        
        
        return cell;
    }
}

//delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 135;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            return 44;
        }
        return 30;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 44;
        }
        CGFloat width = (kScreenWidth - 30)/2.0;
        CGFloat height = (width * 0.7 + 40) * 2 + 30;
        return height;
    }else{
        if (indexPath.row == 0) {
            return 44;
        }
        return 80/375.0 * kScreenWidth;
    }
}



@end
