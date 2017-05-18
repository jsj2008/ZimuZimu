//
//  ConfuseAnswerDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//



#import "ConfuseAnswerDetailTableView.h"
#import "ConfuseTagCell.h"
#import "ConfuseContentCell.h"
#import "ConfuseContentCellLayoutFrame.h"
#import "ConfuseExpertAnswerCell.h"
#import "ExpertAnswerLayoutFrame.h"
#import "HeaderTitleCell.h"
#import "FMDetailCommentHeaderCell.h"
#import "FMDeatilCommentCell.h"
#import "FMDetailCommentLayoutFrame.h"
#import "NoAnswerCell.h"
#import "UIView+ViewController.h"
#import "InsertCommentTableViewController.h"

#import "QuestionExpertAnswerModel.h"
#import "QuestionUserCommentModel.h"


static NSString *confuseTagIdentifier = @"ConfuseTagCell";
static NSString *confuseContentCellIdentifier = @"ConfuseContentCell";
static NSString *expertAnswerCellIdentifier = @"ConfuseExpertAnswerCell";
static NSString *headerTitleCellIdentifier = @"headerTitleCell";
static NSString *commentHeaderIdentifier = @"FMDetailCommentHeaderCell";
static NSString *commentIdentifier = @"FMDetailCommentCell";
static NSString *noAnswerIdentifier = @"NoAnswerCell";
@interface ConfuseAnswerDetailTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ConfuseAnswerDetailTableView

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
        [self registerNib:[UINib nibWithNibName:@"ConfuseExpertAnswerCell" bundle:nil] forCellReuseIdentifier:expertAnswerCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:nil] forCellReuseIdentifier:headerTitleCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailCommentHeaderCell" bundle:nil] forCellReuseIdentifier:commentHeaderIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDeatilCommentCell" bundle:nil] forCellReuseIdentifier:commentIdentifier];
        [self registerNib:[UINib nibWithNibName:@"NoAnswerCell" bundle:nil] forCellReuseIdentifier:noAnswerIdentifier];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return _expertAnswerModelArray.count + 1;
    }else if (section == 2){
        if (_userCommentModelArray.count == 0 || _userCommentModelArray == nil) {
            return 2;
        }
        return _userCommentModelArray.count + 1;
    }
    return 2;
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
    }else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (_expertAnswerModelArray.count == 0 || _expertAnswerModelArray == nil) {
                NoAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:noAnswerIdentifier];
                cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width, 0, 0);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.placeholderText = @"暂时还没有专家回答，您可以一对一咨询\n更快速的解决您的问题";
                
                return cell;
            }
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleCellIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 0, 0, cell.width);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"专家解读";
            
            return cell;
        }else{
            ConfuseExpertAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:expertAnswerCellIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 0);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ExpertAnswerModel *expertAnswerModel = _expertAnswerModelArray[indexPath.row - 1];
            ExpertAnswerLayoutFrame *layoutFrame = [[ExpertAnswerLayoutFrame alloc]initWithExpertAnswerModel:expertAnswerModel];
            cell.layoutFrame = layoutFrame;
            
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            FMDetailCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:commentHeaderIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width - 0.5, 0, 0);
            
            return cell;
        }else{
            if (_userCommentModelArray.count == 0 || _userCommentModelArray == nil) {
                NoAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:noAnswerIdentifier];
                cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width, 0, 0);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.placeholderText = @"暂时还没有用户评论\n快去评论吧";
                
                return cell;
            }else{
                FMDeatilCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UserCommentModel *model = _userCommentModelArray[indexPath.row - 1];
                FMDetailCommentLayoutFrame *layoutFrame = [[FMDetailCommentLayoutFrame alloc]initWithUserCommentModel:model];
                cell.userCommentLayoutFrame = layoutFrame;
                
                return cell;
            }
        }
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            InsertCommentTableViewController *insertCommentVC = [[InsertCommentTableViewController alloc]init];
            insertCommentVC.questionId = _questionModel.questionId;
            [self.viewController.navigationController pushViewController:insertCommentVC animated:YES];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 45;
        }
        ConfuseContentCellLayoutFrame *layoutFrame = [[ConfuseContentCellLayoutFrame alloc]initWithModel:_questionModel];
        return layoutFrame.cellHeight;
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return 45;
        }else{
            if (_expertAnswerModelArray.count == 0 || _expertAnswerModelArray == nil) {
                return 60;
            }else{
                ExpertAnswerModel *expertAnswerModel = _expertAnswerModelArray[indexPath.row - 1];
                ExpertAnswerLayoutFrame *layoutFrame = [[ExpertAnswerLayoutFrame alloc]initWithExpertAnswerModel:expertAnswerModel];
                return layoutFrame.cellHeight;
            }
        }
    }else{
        if (indexPath.row == 0) {
            return 50;
        }else{
            if (_userCommentModelArray.count == 0 || _userCommentModelArray == nil) {
                return 60;
            }else{
                UserCommentModel *model = _userCommentModelArray[indexPath.row - 1];
                FMDetailCommentLayoutFrame *layoutFrame = [[FMDetailCommentLayoutFrame alloc]initWithUserCommentModel:model];
                return layoutFrame.cellHeight;
            }
        }
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

//隐藏多余分割线
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

- (void)setExpertAnswerModelArray:(NSArray *)expertAnswerModelArray{
    if (_expertAnswerModelArray != expertAnswerModelArray) {
        _expertAnswerModelArray = expertAnswerModelArray;
        [self reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)setUserCommentModelArray:(NSArray *)userCommentModelArray{
    if (_userCommentModelArray != userCommentModelArray) {
        _userCommentModelArray = userCommentModelArray;
        [self reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)setCareState:(NSInteger)careState{
    ConfuseContentCell *cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.careState = careState;
}


@end
