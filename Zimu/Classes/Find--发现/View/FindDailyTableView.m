//
//  FindDailyTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindDailyTableView.h"
#import "FindListCell.h"
#import "UIView+ViewController.h"

static NSString *identifier = @"FindListCell";

@interface FindDailyTableView ()<UITableViewDelegate, UITableViewDataSource>

@end


@implementation FindDailyTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"FindListCell" bundle:nil] forCellReuseIdentifier:identifier];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    FindListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleString = @"如何让他变得更加乐观向上爱与人交流爱与人分享";
    cell.bgImageString = [NSString stringWithFormat:@"find_list%li",(indexPath.row + 1)%3 + 1];
    switch (indexPath.row) {
        case 0:
            cell.findCellType = FindCellTypeArticle;
            cell.countString = @"1000";
            break;
            
        case 1:
            cell.findCellType = FindCellTypeVideo;
            cell.countString = @"1500";
            break;
            
        case 2:
            cell.findCellType = FindCellTypeFM;
            cell.countString = @"2000";
            break;
        case 3:
            cell.findCellType = FindCellTypeVideo;
            cell.countString = @"2500";
            break;
        case 4:
            cell.findCellType = FindCellTypeFM;
            cell.countString = @"3000";
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 * kScreenWidth / 375.0;
}



@end
