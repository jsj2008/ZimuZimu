//
//  SubscribeDetailRightViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeDetailRightViewController.h"
#import "DailyLookTitleCell.h"
#import "DailyStudyCell.h"
#import "ArticleViewController.h"

static NSString *dailyLookTitleIdentifier = @"DailyLookTitleCell";
static NSString *dailyStudyIdentifier = @"DailyStudyCell";
@interface SubscribeDetailRightViewController ()

@end

@implementation SubscribeDetailRightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeGray;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DailyLookTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:dailyLookTitleIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"DailyStudyCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:dailyStudyIdentifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        DailyLookTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:dailyLookTitleIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = themeGray;
        
        return cell;
    }
    DailyStudyCell *cell = [tableView dequeueReusableCellWithIdentifier:dailyStudyIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageString = @"yiding_meirikan_pic";
    
    return cell;
}

@end
