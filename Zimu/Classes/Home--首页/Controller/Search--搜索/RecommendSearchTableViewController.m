//
//  RecommendSearchTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "RecommendSearchTableViewController.h"
#import "MJRefresh.h"
#import "ExpertTableViewCell.h"
#import "QuestionTableViewCell.h"

static NSString *headerCellIdentifier = @"headerCell";
static NSString *expertCellIdentifier = @"expertCell";
static NSString *questionCellIdentifier = @"questionCell";

@interface RecommendSearchTableViewController ()

@end

@implementation RecommendSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self registerCellIdentifier];
    
    [self setupMJRefreshing];
}

//注册单元格
- (void)registerCellIdentifier{
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:headerCellIdentifier];
    [self.tableView registerClass:[ExpertTableViewCell class] forCellReuseIdentifier:expertCellIdentifier];
    [self.tableView registerClass:[QuestionTableViewCell class] forCellReuseIdentifier:questionCellIdentifier];
}

- (void)setupMJRefreshing{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
}
- (void)refresh{
    __weak RecommendSearchTableViewController *weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:1.5f repeats:NO block:^(NSTimer * _Nonnull timer) {
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellIdentifier forIndexPath:indexPath];
                cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 0, 0.5, 0);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"咨询专家(300位)";
                cell.textLabel.font = [UIFont systemFontOfSize:12];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                
                return cell;
            }else{
                ExpertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:expertCellIdentifier forIndexPath:indexPath];
                cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 0, 0.5, 0);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

                cell.name = @"专家名字";
                cell.tagString1 = @"亲子教育";
                cell.tagString2 = @"学习";
                cell.tagString3 = @"沉迷游戏";
                cell.address = @"杭州 ";
                cell.countString = @"1000";
                cell.percentString = @"97";
                
                return cell;
            }
        }else{
            if (indexPath.row == 0) {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:headerCellIdentifier forIndexPath:indexPath];
                cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 0, 0.5, 0);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.text = @"问答内容(300)";
                cell.textLabel.font = [UIFont systemFontOfSize:12];
                cell.textLabel.textColor = [UIColor darkGrayColor];
                
                return cell;
            }
            QuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:questionCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(cell.height - 0.5, 0, 0.5, 0);
            QuestionCellLayout *questionLayout = [[QuestionCellLayout alloc]init];
            cell.questionCellLayout = questionLayout;
            
            return cell;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 35;
        }
        return 80;
    }else{
        if (indexPath.row == 0) {
            return 35;
        }
        QuestionCellLayout *questionLayout = [[QuestionCellLayout alloc]init];
        
        return questionLayout.cellHeight;
    }
}

@end
