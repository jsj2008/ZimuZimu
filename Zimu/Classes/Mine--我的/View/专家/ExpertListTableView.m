//
//  ExpertListTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertListTableView.h"
#import "MyExpertTableViewCell.h"
#import "MyExpertCellLayoutFrame.h"

static NSString *identifier = @"MyExpertTableViewCell";
@interface ExpertListTableView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ExpertListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"MyExpertTableViewCell" bundle:nil] forCellReuseIdentifier:identifier];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyExpertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle  =UITableViewCellSelectionStyleNone;
    MyExpertCellLayoutFrame *layoutFrame = [[MyExpertCellLayoutFrame alloc]init];
    cell.layoutFrame = layoutFrame;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 85;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 35)];
    view.backgroundColor = themeGray;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, view.width - 20, view.height)];
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = themeBlack;
    if (section == 0) {
        label.text = @"咨询过的专家";
    }else{
        label.text = @"更多专家推荐";
    }
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

@end
