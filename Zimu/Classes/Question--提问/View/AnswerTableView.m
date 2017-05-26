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
#import "HeaderTitleCell.h"
#import "QuestionResultCell.h"
#import "SearchQuestionModel.h"

static NSString *confuseTagIdentifier = @"ConfuseTagCell";
static NSString *confuseContentCellIdentifier = @"ConfuseContentCell";
static NSString *headerTitleCellIdentifier = @"headerTitleCell";
static NSString *resultIdentifier = @"QuestionResultCell";

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
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:nil] forCellReuseIdentifier:headerTitleCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"QuestionResultCell" bundle:nil] forCellReuseIdentifier:resultIdentifier];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return  1 + _resultArray.count;
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
    }else{
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleCellIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 0);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"类似问题";
            
            return cell;
        }
        QuestionResultCell *cell = [tableView dequeueReusableCellWithIdentifier:resultIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        SearchQuestionResultModel *resultModel = _resultArray[indexPath.row - 1];
        cell.model = resultModel;
        
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
        
    }else{
        if (indexPath.row == 0) {
            return 45;
        }
        return 70;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
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

- (void)setResultArray:(NSArray *)resultArray{
    if (_resultArray != resultArray) {
        _resultArray = resultArray;
        [self reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)setCareState:(NSInteger)careState{
    ConfuseContentCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.careState = careState;
}

@end
