//
//  AgeRangeView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AgeRangeView.h"

static NSString *cellId = @"ageRange";
@interface AgeRangeView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation AgeRangeView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
        _dataArray = @[@"5-10", @"10-15", @"15-17"];
        
        self.tableFooterView = [[UIView alloc] init];
        self.dataSource = self;
        
    }
    return self;
}

#pragma mark - dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    cell.separatorInset = UIEdgeInsetsZero;
    cell.textLabel.text = [(NSString *)_dataArray[indexPath.row] stringByAppendingString:@"岁"];
    
    return cell;
}


@end
