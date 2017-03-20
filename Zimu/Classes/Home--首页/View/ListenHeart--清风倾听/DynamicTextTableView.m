//
//  DynamicTextTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "DynamicTextTableView.h"
#import "DynamicTextCell.h"

static NSString *identifier = @"dynamicTextCell";
@interface DynamicTextTableView ()<UITableViewDataSource, UITableViewDelegate>

@end
@implementation DynamicTextTableView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"DynamicTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
}

//DataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleString = _textArray[indexPath.row];
    
    return cell;
}

//Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}

- (void)setTextArray:(NSArray *)textArray{
    if (_textArray != textArray) {
        _textArray = textArray;
        [self reloadData];
    }
}


@end
