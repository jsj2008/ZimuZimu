//
//  BookCourseTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookCourseTableView.h"
#import "BookCourseHeaderCell.h"
#import "BookCourseCell.h"

static NSString *headerIdentifier = @"BookCourseHeaderCell";
static NSString *bookIdentifier = @"BookCourseCell";

@interface BookCourseTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation BookCourseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorColor = themeGray;
        [self registerNib:[UINib nibWithNibName:@"BookCourseHeaderCell" bundle:nil] forCellReuseIdentifier:headerIdentifier];
        [self registerNib:[UINib nibWithNibName:@"BookCourseCell" bundle:nil] forCellReuseIdentifier:bookIdentifier];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        BookCourseHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 1.0f, 10, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    BookCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:bookIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 40;
    }
    return ((kScreenWidth - 40)/3.0)/0.7 + 40 + 20;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
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
