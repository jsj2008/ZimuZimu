//
//  AnswerTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

//  刚提交后跳转的页面

#import "AnswerTableView.h"
#import "ConfuseTagCell.h"
#import "ConfuseContentCell.h"
#import "ConfuseContentCellLayoutFrame.h"
#import "NoAnswerCell.h"
#import "HeaderTitleCell.h"
#import "ExpertListCell.h"

static NSString *confuseTagIdentifier = @"ConfuseTagCell";
static NSString *confuseContentCellIdentifier = @"ConfuseContentCell";
static NSString *noAnswerCellIdentifier = @"NoAnswerCell";
static NSString *headerTitleCellIdentifier = @"headerTitleCell";
static NSString *expertListCellIdentifier = @"ExpertListCell";

@interface AnswerTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation AnswerTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self hideExtraLines];
        self.backgroundColor = themeGray;
        self.separatorColor = themeGray;
        
        [self registerNib:[UINib nibWithNibName:@"ConfuseTagCell" bundle:nil] forCellReuseIdentifier:confuseTagIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ConfuseContentCell" bundle:nil] forCellReuseIdentifier:confuseContentCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"NoAnswerCell" bundle:nil] forCellReuseIdentifier:noAnswerCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ExpertListCell" bundle:nil] forCellReuseIdentifier:expertListCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:nil] forCellReuseIdentifier:headerTitleCellIdentifier];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else if (section == 1) {
        return 1;
    }
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ConfuseTagCell *cell = [tableView dequeueReusableCellWithIdentifier:confuseTagIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(0, cell.width, 0, 0);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tagArray = [_questionModel.keyWord componentsSeparatedByString:@","];
            
            return cell;
        }
        ConfuseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:confuseContentCellIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ConfuseContentCellLayoutFrame *layoutFrame = [[ConfuseContentCellLayoutFrame alloc]initWithModel:_questionModel];
        cell.layoutFrame = layoutFrame;
        
        return cell;
    }else if (indexPath.section == 1){
        NoAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:noAnswerCellIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleCellIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 0);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"专家推荐";
            
            return cell;
        }
        ExpertListCell *cell = [tableView dequeueReusableCellWithIdentifier:expertListCellIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageString = @"mine_head_placeholder";
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 45;
        }
        ConfuseContentCellLayoutFrame *layoutFrame = [[ConfuseContentCellLayoutFrame alloc]initWithModel:_questionModel];
        return layoutFrame.cellHeight;
        
    }else if (indexPath.section == 1){
        return 60;
    }else{
        if (indexPath.row == 0) {
            return 45;
        }
        return 80;
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



- (void)hideExtraLines{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeWhite;
    self.tableFooterView = view;
}


#pragma mark - 数据
- (void)setQuestionModel:(QuestionModel *)questionModel{
    if (_questionModel != questionModel) {
        _questionModel = questionModel;
        [self reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    }
}



@end
