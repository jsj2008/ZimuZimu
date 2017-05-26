//
//  QuestionResultTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionResultTableView.h"
#import "QuestionResultCell.h"
#import "AnswerDetailViewController.h"
#import "AnswerViewController.h"
#import "UIView+ViewController.h"
#import "SearchQuestionModel.h"

static NSString *identifier = @"QuestionResultCell";
@interface QuestionResultTableView ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@end

@implementation QuestionResultTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        _resultArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        [self hideExtraLines];
        
        [self registerNib:[UINib nibWithNibName:@"QuestionResultCell" bundle:nil] forCellReuseIdentifier:identifier];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _resultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionResultCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 10, 0, 0);
    
    SearchQuestionResultModel *model = _resultArray[indexPath.row];
    cell.model = model;
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeWhite;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.width - 20, 25)];
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"相关问题推荐";
    label.textColor = [UIColor colorWithHexString:@"999999"];
    label.textAlignment = NSTextAlignmentLeft;
    [view addSubview:label];
    
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionResultCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    NSLog(@"title : %@",cell.titleString);
    
    SearchQuestionResultModel *model = _resultArray[indexPath.row];
    
    AnswerViewController *answerVC = [[AnswerViewController alloc]init];
    answerVC.questionID = model.questionId;
    [self.viewController.navigationController pushViewController:answerVC animated:YES];
    
}

- (void)setResultArray:(NSMutableArray *)resultArray{
    _resultArray = resultArray;
    [self reloadData];
}

- (void)hideExtraLines{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeWhite;
    self.tableFooterView = view;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([self.scrollDelegate respondsToSelector:@selector(questionResultTableViewDidScroll)]) {
        [self.scrollDelegate questionResultTableViewDidScroll];
    }
}


@end
