//
//  SubscribeDetailMidViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeDetailMidViewController.h"
#import "DailyLookTitleCell.h"
#import "ContinueListenCell.h"

static NSString *dailyLookTitleIdentifier = @"DailyLookTitleCell";
static NSString *continueListenIdentifier = @"ContinueListenCell";
@interface SubscribeDetailMidViewController ()

@end

@implementation SubscribeDetailMidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeGray;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"DailyLookTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:dailyLookTitleIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"ContinueListenCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:continueListenIdentifier];
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
    ContinueListenCell *cell = [tableView dequeueReusableCellWithIdentifier:continueListenIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageString = @"course_FM_placeholdImg";
    
    return cell;
}

@end
