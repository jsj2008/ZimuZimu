//
//  VideoCourseTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "VideoCourseTableView.h"
#import "VideoCourseHeaderCell.h"

static NSString *headerIdentifier = @"VideoCourseHeaderCell";
@interface VideoCourseTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation VideoCourseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorColor = themeGray;
        [self registerNib:[UINib nibWithNibName:@"VideoCourseHeaderCell" bundle:nil] forCellReuseIdentifier:headerIdentifier];
        
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
        VideoCourseHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(cell.height - 1.0f, 10, 0, 0);
        
        return cell;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 2) {
        return 0;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


@end
