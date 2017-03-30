//
//  CityCourseTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseTableView.h"
//#import "CityCourseHeaderCell.h"
#import "CityCourseCell.h"

//static NSString *cityCourseHeaderIdentifier = @"CityCourseHeaderCell";
static NSString *cityCourseIdentifier = @"CityCourseCell";

@interface CityCourseTableView ()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation CityCourseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
//        [self registerNib:[UINib nibWithNibName:@"CityCourseHeaderCell" bundle:nil] forCellReuseIdentifier:cityCourseHeaderIdentifier];
        [self registerNib:[UINib nibWithNibName:@"CityCourseCell" bundle:nil] forCellReuseIdentifier:cityCourseIdentifier];
        
    }
    return self;
}


//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        CityCourseHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCourseHeaderIdentifier];
//        cell.separatorInset = UIEdgeInsetsMake(cell.height - 1, 10, 0, 0);
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//        return cell;
//    }else{
//    }
    CityCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:cityCourseIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.separatorInset = UIEdgeInsetsMake(cell.height - 1, 10, 0, 0);
    
    return cell;
    
}

//delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        return 40;
//    }
    return 185 / 375.0 * kScreenWidth;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return CGFLOAT_MIN;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeGray;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, self.width - 20, 20)];
    label.text = @"当前：杭州";
    label.textColor = [UIColor colorWithHexString:@"666666"];
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentLeft;
    
    [view addSubview:label];
    
    return view;
}



@end
