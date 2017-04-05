//
//  FindTestListTableView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindTestListTableView.h"
#import "FindTestListCell.h"
#import "FindHeadCell.h"

static NSString *imgCell = @"FindTestListCell";
static NSString *headCell = @"FindHeadCell";

@interface FindTestListTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FindTestListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        UINib *nib = [UINib nibWithNibName:imgCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:imgCell];
        
        UINib *nib2 = [UINib nibWithNibName:headCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib2 forCellReuseIdentifier:headCell];
        
        self.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        self.dataSource = self;
        self.delegate = self;
        
    }
    return self;
}

#pragma mark -代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        FindHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell forIndexPath:indexPath];
        cell.titleLabel.text = @"行为改善";
        cell.line.hidden = YES;
        [cell.seeMoreBtn setTitle:@"查看全部" forState:UIControlStateNormal];
        return cell;
    }else{
        FindTestListCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCell forIndexPath:indexPath];
        cell.img.image = [UIImage imageNamed:@"home_FM3"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }else{
        return (kScreenWidth - 20) * 0.37 + 20;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
