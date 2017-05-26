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
#import "HomeVideoDetailViewController.h"


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
//        [self registerNib:[UINib nibWithNibName:@"FindListHeaderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:headerIdentifier];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if (indexPath.section == 0) {
//        FindListHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.bgImageString = @"find_header";
//        
//        return cell;
//    }
    FindListCell *cell = [tableView dequeueReusableCellWithIdentifier:listIdentifier];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.titleString = @"如何让他变得更加乐观向上爱与人交流爱与人分享";
//    cell.bgImageString = [NSString stringWithFormat:@"find_list%li",(indexPath.row + 1)%3 + 1];
    cell.model = _modelArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section == 0) {
//        //每日精选
//        FindDailySelectionViewController *dailySelectionVC = [[FindDailySelectionViewController alloc]init];
//        [self.viewController.navigationController pushViewController:dailySelectionVC animated:YES];
//    }else{
//}
    ParentSchoolItem *itemModel = _modelArray[indexPath.row];
    FindListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"findCellType : %i",cell.findCellType);
    switch (cell.findCellType) {
        case FindCellTypeArticle:{          //文章
            ArticleViewController *articleVC = [[ArticleViewController alloc]init];
            articleVC.articleID = itemModel.qinziid;
            articleVC.articleTitle = itemModel.title;
//            [articleVC loadWebURLSring:@"http://mp.weixin.qq.com/s/WFlfD_GgedmXzlGvx3maxw"];
            [self.viewController.navigationController pushViewController:articleVC animated:YES];
        }
            break;
            
        case FindCellTypeFM:{               //FM
            FMViewController *fmVC = [[FMViewController alloc]init];
            fmVC.fmId = itemModel.qinziid;
            [self.viewController.navigationController pushViewController:fmVC animated:YES];
        }
            break;
            
        case FindCellTypeVideo:{            //视频
            HomeVideoDetailViewController *videoDetailVC = [[HomeVideoDetailViewController alloc]init];
            videoDetailVC.videoId = itemModel.qinziid;
            [self.viewController.navigationController pushViewController:videoDetailVC animated:YES];
        }
            break;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180 * kScreenWidth / 375.0;
}


- (void)setModelArray:(NSArray *)modelArray{
    if (_modelArray != modelArray) {
        _modelArray = modelArray;
        [self reloadData];
    }
}



@end
