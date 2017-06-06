//
//  SearchFriendsListView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SearchFriendsListView.h"
#import "SearchFriendsFriendCell.h"
#import "UIView+ViewController.h"
#import "SearchFriendDetailViewController.h"
#import "SearchFriendMyMsgCell.h"


static NSString *cellId = @"SearchFriendsFriendCell";
static NSString *section1Id = @"normalCellFriend";
static NSString *myMsgCell = @"SearchFriendMyMsgCell";

@interface SearchFriendsListView () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation SearchFriendsListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        UINib *nib = [UINib nibWithNibName:cellId bundle:[NSBundle mainBundle]];
        [self registerNib:nib forCellReuseIdentifier:cellId];
        
        UINib *nib1 = [UINib nibWithNibName:myMsgCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellReuseIdentifier:myMsgCell];
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:section1Id];
//        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.delegate = self;
        self.dataSource = self;
        
    }
    return self;
}

#pragma mark - DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 1;
    if (section == 1) return 3;
    if (section == 2) return 8;
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        SearchFriendMyMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:myMsgCell forIndexPath:indexPath];
        [cell setName:@"我啊" idStr:@"293857" age:8 imgUrlString:@"asdfij"];
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {                               //分享我的名片
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:section1Id];
            cell.imageView.image = [UIImage imageNamed:@"add_fenxiang"];
            cell.textLabel.text = @"分享我的名片";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.separatorInset = UIEdgeInsetsZero;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row == 2){                          //输入手机号搜索
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:section1Id];
            cell.imageView.image = [UIImage imageNamed:@"add_shouji"];
            cell.textLabel.text = @"输入手机号搜索";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.separatorInset = UIEdgeInsetsZero;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{                                                  //按条件查找陌生人
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:section1Id];
            cell.imageView.image = [UIImage imageNamed:@"add_chahzao"];
            cell.textLabel.text = @"按条件查找陌生人";
            cell.textLabel.font = [UIFont systemFontOfSize:16];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.separatorInset = UIEdgeInsetsZero;
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        SearchFriendsFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
//        [cell setName:@"我啊124" idStr:@"29385124 7" age:8 imgUrlString:@"asdfij" s];
        [cell setSex: indexPath.row % 2? 1:0];
//        cell.separatorInset = UIEdgeInsetsMake(0, 0, 10, 0);
//        cell.separatorInset = UIEdgeInsetsZero;
        cell.separatorInset = UIEdgeInsetsMake(0, kScreenWidth, 0, 0);
        cell.addFriendBtn.hidden = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    if (section == 0) return 85;
    if (section == 1) return 45;
    if (section == 2) return 85;
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) return 0;
    if (section == 1) return 10;
    if (section == 2) return 30;
    
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 2) {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];//创建一个视图
        
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 30)];
//        headerLabel.backgroundColor = [UIColor clearColor];
        headerLabel.font = [UIFont systemFontOfSize:15.0];
        headerLabel.textColor = [UIColor colorWithHexString:@"666666"];
        headerLabel.text = @"猜你感兴趣";
        [headerView addSubview:headerLabel];
        
        headerView.backgroundColor = themeGray;
        return headerView;
    }
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = themeGray;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }else{
            if (indexPath.row == 1) {
                SearchFriendDetailViewController *searchDeVC = [[SearchFriendDetailViewController alloc] initWithStyle:searchFriendStyleMsg];
                [self.viewController.navigationController pushViewController:searchDeVC animated:YES];
            }else {
                SearchFriendDetailViewController *searchDeVC = [[SearchFriendDetailViewController alloc] initWithStyle:searchFriendStyleId];
                [self.viewController.navigationController pushViewController:searchDeVC animated:YES];
                
            }
        }
    }
    
    
}

@end
