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

@property (nonatomic, assign) NSInteger i;

@end
@implementation DynamicTextTableView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.delegate = self;
    self.dataSource = self;
    
//    _textArray = @[@"孩子学习老不好，怎么办",@"孩子没救了",@"多半是废了",@"打一顿就好了",@"再生一个就好了",@"有时候放弃会是更加明智的选择",@"孩子学习老不好，孩子学习老不好，孩子学习老不好",@"开始的福建省分行数据库",@"发达国家对方了解了",@"的色即是空",@"发快递街坊邻居"];
//    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerNib:[UINib nibWithNibName:@"DynamicTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
}

//DataSourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _textArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicTextCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleString = _textArray[indexPath.row];
    
    return cell;
}

//Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)setTextArray:(NSArray *)textArray{
    if (_textArray != textArray) {
        _textArray = [NSMutableArray arrayWithArray:textArray];
        [_textArray addObject:textArray[0]];
        [_textArray addObject:textArray[1]];
        [_textArray addObject:textArray[2]];
        [_textArray addObject:textArray[3]];
        [_textArray addObject:textArray[4]];
        
        [self reloadData];
        [self timeStart];
    }
}

- (void)timeStart{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.025 target:self selector:@selector(scrol) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
- (void)scrol{
    _i++;
    if (_i >= (int)self.contentSize.height - self.height) {
        _i = 0;
    }
    
    self.contentOffset = CGPointMake(0, _i);
}


@end
