//
//  SubscribeLecturerDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeLecturerDetailTableView.h"
#import "DailyLookTitleCell.h"
#import "DailyLookCell.h"

static NSString *dailyLookTitleIdentifier = @"DailyLookTitleCell";
static NSString *dailyLookIdentifier = @"DailyLookCell";


static NSString *SLDTitleCellIdentifier = @"SLDTitleCell";
static NSString *SLDContentCellIdentifier = @"SLDContentCell";

@interface SubscribeLecturerDetailTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SubscribeLecturerDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = themeGray;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"DailyLookTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:dailyLookTitleIdentifier];
        [self registerNib:[UINib nibWithNibName:@"DailyLookCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:dailyLookIdentifier];

    }
    return self;
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
//    if (indexPath.row == 0) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SLDTitleCellIdentifier];
//        cell.textLabel.text = @"相关资质";
//        cell.textLabel.font = [UIFont systemFontOfSize:15];
//        
//        return cell;
//    }else{
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SLDContentCellIdentifier];
//        cell.textLabel.text = @"清华大学心理学博士";
//        cell.textLabel.font = [UIFont systemFontOfSize:14];
//        
//        return cell;
//    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        DailyLookTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:dailyLookTitleIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = themeGray;
        
        return cell;
    }
    DailyLookCell *cell = [tableView dequeueReusableCellWithIdentifier:dailyLookIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}




@end
