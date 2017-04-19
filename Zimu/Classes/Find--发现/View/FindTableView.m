//
//  FindTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindTableView.h"
#import "FindListHeaderCell.h"
#import "FindListCell.h"
#import "FindDailySelectionViewController.h"
#import "UIView+ViewController.h"
#import "ArticleViewController.h"
#import "FMViewController.h"
#import "HomeVideoViewController.h"

static NSString *headerIdentifier = @"FindListHeaderCell";
static NSString *listIdentifier = @"FindListCell";

@interface FindTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FindTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"FindListCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:listIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FindListHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:headerIdentifier];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        FindListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.bgImageString = @"find_header";
        
        return cell;
    }
    FindListCell *cell = [tableView dequeueReusableCellWithIdentifier:listIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleString = @"如何让他变得更加乐观向上爱与人交流爱与人分享";
<<<<<<< HEAD
    cell.bgImageString = [NSString stringWithFormat:@"find_list%li",(indexPath.row + 1)%3 + 1];
    switch (indexPath.row) {
        case 0:
            cell.findCellType = FindCellTypeArticle;
            cell.countString = @" 1000";
            break;
            
        case 1:
            cell.findCellType = FindCellTypeVideo;
            cell.countString = @" 1500";
            break;
            
        case 2:
            cell.findCellType = FindCellTypeFM;
            cell.countString = @" 2000";
            break;
        case 3:
            cell.findCellType = FindCellTypeVideo;
            cell.countString = @" 2500";
            break;
        case 4:
            cell.findCellType = FindCellTypeFM;
            cell.countString = @" 3000";
            break;
    }
=======
    cell.bgImageString = [NSString stringWithFormat:@"find_"];
>>>>>>> origin/master
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //每日精选
        FindDailySelectionViewController *dailySelectionVC = [[FindDailySelectionViewController alloc]init];
        [self.viewController.navigationController pushViewController:dailySelectionVC animated:YES];
    }else{
        FindListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        NSLog(@"findCellType : %i",cell.findCellType);
        switch (cell.findCellType) {
            case FindCellTypeArticle:{          //文章
                ArticleViewController *articleVC = [[ArticleViewController alloc]init];
                [articleVC loadWebURLSring:@"http://mp.weixin.qq.com/s/WFlfD_GgedmXzlGvx3maxw"];
                [self.viewController.navigationController pushViewController:articleVC animated:YES];
            }
                break;
                
            case FindCellTypeFM:{               //FM
                FMViewController *fmVC = [[FMViewController alloc]init];
                [self.viewController.navigationController pushViewController:fmVC animated:YES];
            }
                break;
                
            case FindCellTypeVideo:{            //视频
                HomeVideoViewController *videoVC = [[HomeVideoViewController alloc]init];
                [self.viewController.navigationController pushViewController:videoVC animated:YES];
            }
                break;
        }
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 175 * kScreenWidth / 375.0;
    }
    return 180 * kScreenWidth / 375.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 1) {
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
