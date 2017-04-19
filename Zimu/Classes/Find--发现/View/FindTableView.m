//
//  FindTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindTableView.h"
#import "FindListCell.h"

static NSString *identifier = @"FindListCell";
static NSString *headerIdentifier = @"";

@interface FindTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FindTableView

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
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleString = @"如何让他变得更加乐观向上爱与人交流爱与人分享";
<<<<<<< HEAD
<<<<<<< HEAD
    cell.bgImageString = [NSString stringWithFormat:@"find_list%li",(indexPath.row + 1)%3 + 1];
    switch (indexPath.row) {
        case 0:
            cell.findCellType = FindCellTypeArticle;
            cell.countString = @" 1000";
            break;
            
        case 1:
            cell.findCellType = FindCellTypeVideo;
            cell.countString = @" 1500";
            break;
            
        case 2:
            cell.findCellType = FindCellTypeFM;
            cell.countString = @" 2000";
            break;
        case 3:
            cell.findCellType = FindCellTypeVideo;
            cell.countString = @" 2500";
            break;
        case 4:
            cell.findCellType = FindCellTypeFM;
            cell.countString = @" 3000";
            break;
    }
=======
    cell.bgImageString = [NSString stringWithFormat:@"find_"];
>>>>>>> origin/master
=======
    cell.flagImageString = [NSString stringWithFormat:@"find_"];
>>>>>>> parent of be59786... 发现页
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 175 * kScreenWidth / 375.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
