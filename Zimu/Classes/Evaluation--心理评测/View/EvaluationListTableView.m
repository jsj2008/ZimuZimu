//
//  EvaluationListTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EvaluationListTableView.h"
#import "EvaluationListCell.h"
#import "PsyTestListModel.h"
#import "UIView+ViewController.h"
#import "PsyTestDetailViewController.h"

static NSString *identifier = @"EvaluationListCell";

@interface EvaluationListTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation EvaluationListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        _testListData = [NSMutableArray array];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"EvaluationListCell" bundle:nil] forCellReuseIdentifier:identifier];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _testListData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EvaluationListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.titleString = @"行为改善";
    PsyTestListModel *model = [PsyTestListModel yy_modelWithJSON:_testListData[indexPath.row]];
    cell.titleString = model.testTitle;
    cell.bgImageString = [imagePrefixURL stringByAppendingString:model.testImg];
//    cell.bgImageString = [NSString stringWithFormat:@"find_list%li",(indexPath.row + 1)%3 + 1];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 * kScreenWidth / 375.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PsyTestDetailViewController *vc = [[PsyTestDetailViewController alloc] init];
    PsyTestListModel *model = [PsyTestListModel yy_modelWithJSON:_testListData[indexPath.row]];
    vc.title = model.testTitle;
    vc.testUrl = model.testUrl;
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

@end
