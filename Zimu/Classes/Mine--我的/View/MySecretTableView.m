//
//  MySecretTableView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MySecretTableView.h"
#import "MySecretHeadCell.h"
#import "MySecretDetailCell.h"
#import "MySecretCommentsCell.h"
#import "WXLabel.h"


static NSString *headCell = @"MySecretHeadCell";
static NSString *detailCell = @"MySecretDetailCell";
static NSString *commentCell = @"MySecretCommentsCell";


@interface MySecretTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MySecretTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        UINib *nib1 = [UINib nibWithNibName:headCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellReuseIdentifier:headCell];
        
        UINib *nib2 = [UINib nibWithNibName:detailCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib2 forCellReuseIdentifier:detailCell];
        
        UINib *nib3 = [UINib nibWithNibName:commentCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib3 forCellReuseIdentifier:commentCell];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor colorWithHexString:@"E7E7E7"];
    }
    return self;
}

#pragma mark - tableView代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MySecretHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
        cell.separatorInset = UIEdgeInsetsMake(0, 0.107 * kScreenWidth + 20, 0, 0);
        return cell;
    }else if (indexPath.row == 1){
        MySecretDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        return cell;
    }else{
        MySecretCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
        cell.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) return 0.107 * kScreenWidth + 20;
    if (indexPath.row == 1) {
#pragma mark - 这里要计算一下cell高度，等数据来了
//        CGFloat orginalH = 113;
//        NSString *content = _textTest[indexPath.row - 1];
//        CGFloat height = [WXLabel getTextHeight:14.0 width:kScreenWidth - 20 text:content linespace:1.5];
        return 100;
    }
    if (indexPath.row == 2) return 55;
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *vire = [[UIView alloc] init];
    vire.backgroundColor = [UIColor clearColor];
    return vire;
}

@end
