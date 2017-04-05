//
//  SubscribeFreeReadListView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeFreeReadListView.h"
#import "SubscribeFreeFMCell.h"
#import "SubscribeFreeReadVideoCell.h"
#import "SubscreibeReadFreeHeadCell.h"
#import "FindArticleCell.h"

//cell高度

#define HEAD_HEIGHT 37
#define VIDEO_HEIGHT (kScreenWidth - 20) * 0.4 + 75
#define FM_HEIGHT (kScreenWidth - 20) * 0.16 + 20
#define ARTICLE_HEIGHT (kScreenWidth - 20) * 28 / 71  + 125

//cell复用ID
static NSString *headCell = @"SubscreibeReadFreeHeadCell";
static NSString *videoCell = @"SubscribeFreeReadVideoCell";
static NSString *fmCell = @"SubscribeFreeFMCell";
static NSString *articleCell = @"FindArticleCellSub";

@interface SubscribeFreeReadListView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SubscribeFreeReadListView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //注册复用
        UINib *nib1 = [UINib nibWithNibName:@"SubscreibeReadFreeHeadCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellReuseIdentifier:headCell];
        
        UINib *nib2 = [UINib nibWithNibName:@"SubscribeFreeReadVideoCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib2 forCellReuseIdentifier:videoCell];
        
        UINib *nib3 = [UINib nibWithNibName:@"SubscribeFreeFMCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib3 forCellReuseIdentifier:fmCell];
        
        UINib *nib4 = [UINib nibWithNibName:@"FindArticleCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib4 forCellReuseIdentifier:articleCell];
        
        //设置代理和数据源
        self.delegate = self;
        self.dataSource = self;
     
        self.backgroundColor = themeGray;
        
    }
    return self;
}

#pragma mark - tableview代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 2;
    if (section == 1) return 3;
    if (section == 2) return 3;
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            SubscreibeReadFreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell forIndexPath:indexPath];
            cell.headTitleLabel.text = @"视频";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            SubscribeFreeReadVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:videoCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            SubscreibeReadFreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell forIndexPath:indexPath];
            cell.headTitleLabel.text = @"FM";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            SubscribeFreeFMCell *cell = [tableView dequeueReusableCellWithIdentifier:fmCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }

    }else{
        if (indexPath.row == 0) {
            SubscreibeReadFreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell forIndexPath:indexPath];
            cell.headTitleLabel.text = @"文章";
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            FindArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:articleCell forIndexPath:indexPath];
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, kScreenWidth);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return HEAD_HEIGHT;
    }else{
        if (indexPath.section == 0) {
            return VIDEO_HEIGHT;
        }else if (indexPath.section == 1){
            return FM_HEIGHT;
        }else{
            return ARTICLE_HEIGHT;
        }
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd  %zd", indexPath.section, indexPath.row);
}

@end
