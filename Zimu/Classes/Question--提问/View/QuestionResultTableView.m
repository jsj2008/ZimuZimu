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
#import "UIView+ViewController.h"

static NSString *identifier = @"QuestionResultCell";
@interface QuestionResultTableView ()<UITableViewDelegate, UITableViewDataSource>

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
    cell.titleString = _resultArray[indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionResultCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    NSLog(@"title : %@",cell.titleString);
    
    AnswerDetailViewController *answerDetailVC = [[AnswerDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:answerDetailVC animated:YES];
    
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


@end
