//
//  ListenHeartTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListenHeartTableView.h"
#import "ListenHeartBannerCell.h"
#import "ListenHeartDynamicCell.h"
#import "ListenHeartTutorCell.h"

static NSString *bannerCellIdentifier = @"ListenHeartBannerCell";
static NSString *dynamicIdentifier = @"ListenHeartDynamicCell";
static NSString *listenHeartTutorIdentifier = @"listenHeartTutorCell";
@interface ListenHeartTableView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ListenHeartTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"ListenHeartBannerCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:bannerCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ListenHeartTutorCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:listenHeartTutorIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ListenHeartDynamicCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:dynamicIdentifier];

    }
    return self;
}

//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 1;
    else if (section == 1) return 1;
    else return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        ListenHeartBannerCell *cell = [tableView dequeueReusableCellWithIdentifier:bannerCellIdentifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
    }else if (indexPath.section == 1){
        ListenHeartDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:dynamicIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textArray = @[@"孩子学习老不好，怎么办",@"孩子没救了",@"多半是废了",@"打一顿就好了",@"再生一个就好了",@"有时候放弃会是更加明智的选择",@"孩子学习老不好，孩子学习老不好，孩子学习老不好",@"开始的福建省分行数据库",@"发达国家对方了解了",@"的色即是空",@"发快递街坊邻居"];
        
        return cell;
    }else{
        ListenHeartTutorCell *cell = [tableView dequeueReusableCellWithIdentifier:listenHeartTutorIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageString = [NSString stringWithFormat:@"home_course%li",indexPath.row + 1];
        
        return cell;
    }
}

//delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) return 220/375.0 * kScreenWidth;
    else if (indexPath.section == 1) return 250/375.0 * kScreenWidth;
    else return 80;
}



@end
