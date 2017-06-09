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
#import "SingleTagCell.h"

#import "RecommendQuestionCell.h"
#import "RecommendQuestionLayoutFrame.h"

static NSString *singleTagIdentifier = @"SingleTagCell";
static NSString *confuseContentCellIdentifier = @"ConfuseContentCell";
static NSString *headerTitleCellIdentifier = @"headerTitleCell";
static NSString *recommendQuestionIdentifier = @"RecommendQuestionCell";

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
        
        [self registerClass:[SingleTagCell class] forCellReuseIdentifier:singleTagIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ConfuseContentCell" bundle:nil] forCellReuseIdentifier:confuseContentCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:nil] forCellReuseIdentifier:headerTitleCellIdentifier];
        [self registerClass:[RecommendQuestionCell class] forCellReuseIdentifier:recommendQuestionIdentifier];
        
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
            SingleTagCell *cell = [tableView dequeueReusableCellWithIdentifier:singleTagIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(0, cell.width, 0, 0);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tagText = _questionModel.categoryName;
            
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
        RecommendQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendQuestionIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        RecommendQuestionModel *resultModel = _resultArray[indexPath.row - 1];
        RecommendQuestionLayoutFrame *layoutFrame = [[RecommendQuestionLayoutFrame alloc]initWithModel:resultModel];
        cell.layoutFrame = layoutFrame;
        
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 40;
        }
        ConfuseContentCellLayoutFrame *layoutFrame = [[ConfuseContentCellLayoutFrame alloc]initWithModel:_questionModel];
        return layoutFrame.cellHeight;
        
    }else{
        if (indexPath.row == 0) {
            return 45;
        }
        RecommendQuestionModel *resultModel = _resultArray[indexPath.row - 1];
        RecommendQuestionLayoutFrame *layoutFrame = [[RecommendQuestionLayoutFrame alloc]initWithModel:resultModel];
        return layoutFrame.cellHeight;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecommendQuestionModel *resultModel = _resultArray[indexPath.row - 1];
    if ([self.answerDelegate respondsToSelector:@selector(answerTableViewDidSelectCell:)]) {
        [self.answerDelegate answerTableViewDidSelectCell:resultModel];
    }
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
