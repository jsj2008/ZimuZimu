//
//  SubmitCompleteTableView.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubmitCompleteTableView.h"
#import "SubmitCompleteCell.h"
#import "QuestionResultCell.h"
#import "AnswerViewController.h"
#import "UIView+ViewController.h"

@interface SubmitCompleteTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

static NSString *submitCompleteCellIdentifier = @"SubmitCompleteCell";
static NSString *questionResultCellIdentifier = @"QuestionResultCell";
static NSString *identifier = @"headerCell";
@implementation SubmitCompleteTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self hideExtraLines];
        self.separatorColor = themeGray;
        
        [self registerClass:[SubmitCompleteCell class] forCellReuseIdentifier:submitCompleteCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"QuestionResultCell" bundle:nil] forCellReuseIdentifier:questionResultCellIdentifier];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return _resultArray.count + 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SubmitCompleteCell *cell = [tableView dequeueReusableCellWithIdentifier:submitCompleteCellIdentifier];
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            cell.textLabel.text = @"类似问题：";
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.textLabel.textColor = [UIColor colorWithHexString:@"999999"];
            
            return cell;
        }
        QuestionResultCell *cell = [tableView dequeueReusableCellWithIdentifier:questionResultCellIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 10);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        SearchQuestionResultModel *model = _resultArray[indexPath.row - 1];
        cell.model = model;
        
        return cell;        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 150;
    }else{
        if (indexPath.row == 0) {
            return 40;
        }
        return 70;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}

- (void)setResultArray:(NSMutableArray *)resultArray{
    _resultArray = resultArray;
    [self reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionResultCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    NSLog(@"title : %@",cell.titleString);
    
    SearchQuestionResultModel *model = _resultArray[indexPath.row - 1];
    
    AnswerViewController *answerVC = [[AnswerViewController alloc]init];
    answerVC.questionID = model.questionId;
    [self.viewController.navigationController pushViewController:answerVC animated:YES];
    
}


- (void)hideExtraLines{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeWhite;
    self.tableFooterView = view;
}

@end
