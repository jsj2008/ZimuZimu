//
//  HomeVideoDeatilView.m
//  Zimu
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 Zimu. All rights reserved.


//用到了 VideoDetailTitleCell  VideoDetailTextCell  VideoDetailToolCell SubscreibeReadFreeHeadCell FMDetailCommentHeaderCell  FMDeatilCommentCell
//

#import "HomeVideoDeatilView.h"
#import "VideoDetailTitleCell.h"
#import "VideoDetailTextCell.h"
#import "SubscreibeReadFreeHeadCell.h"
#import "VideoDetailToolCell.h"
#import "FMDetailCommentHeaderCell.h"
#import "FMDeatilCommentCell.h"
#import "FMDetailAuthorCell.h"
#import "CourseHotListView.h"

static NSString *titleCell = @"VideoDetailTitleCell";           //专家讲堂
static NSString *deTextCell = @"VideoDetailTextCell";           //孩子学习是个大问题
static NSString *headCell = @"SubscreibeReadFreeHeadCell";      //推荐课程
static NSString *commentCell = @"FMDetailCommentHeaderCell";    //提交评论cell
static NSString *toolBarCell = @"VideoDetailToolCell";          //点赞评论bar
static NSString *authorCell = @"FMDetailAuthorCell";            //作者
static NSString *normalCell = @"videoDetailCellNormal";         //普通
static NSString *commentDetailCell = @"FMDetailCommentCell";    //评论

#define COURSE_FM_HEIGHT        kScreenWidth * 0.214 + 60

@interface HomeVideoDeatilView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)CourseHotListView *hotListView;

@end

@implementation HomeVideoDeatilView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        UINib *nib1 = [UINib nibWithNibName:titleCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib1 forCellReuseIdentifier:titleCell];
        
        UINib *nib2 = [UINib nibWithNibName:deTextCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib2 forCellReuseIdentifier:deTextCell];
        
        UINib *nib3 = [UINib nibWithNibName:headCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib3 forCellReuseIdentifier:headCell];
        
        UINib *nib4 = [UINib nibWithNibName:commentCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib4 forCellReuseIdentifier:commentCell];
        
        UINib *nib5 = [UINib nibWithNibName:toolBarCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib5 forCellReuseIdentifier:toolBarCell];
        
        UINib *nib6 = [UINib nibWithNibName:authorCell bundle:[NSBundle mainBundle]];
        [self registerNib:nib6 forCellReuseIdentifier:authorCell];

        UINib *nib7 = [UINib nibWithNibName:@"FMDeatilCommentCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib7 forCellReuseIdentifier:commentDetailCell];
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCell];
        
        self.backgroundColor = themeGray;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark - 代理数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) return 3;
    if (section == 1) return 1;
    if (section == 2) return 2;
    if (section == 3) return 6;
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            VideoDetailTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:titleCell forIndexPath:indexPath];
            return cell;
        }else if (indexPath.row == 1){
            VideoDetailTextCell *cell = [tableView dequeueReusableCellWithIdentifier:deTextCell forIndexPath:indexPath];
            return cell;
        }else{
            VideoDetailToolCell *cell = [tableView dequeueReusableCellWithIdentifier:toolBarCell forIndexPath:indexPath];
            return cell;
        }
    }else if (indexPath.section == 1){
        FMDetailAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:authorCell forIndexPath:indexPath];
        return cell;
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            SubscreibeReadFreeHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCell forIndexPath:indexPath];
            cell.headTitleLabel.text = @"推荐课程";
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
            if (!_hotListView) {
                UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
                flowLayout.minimumLineSpacing = 0;
                flowLayout.minimumInteritemSpacing = 0;
                flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                
                _hotListView = [[CourseHotListView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 0, COURSE_FM_HEIGHT) collectionViewLayout:flowLayout];
            }
            [cell addSubview:_hotListView];
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            FMDetailCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCell forIndexPath:indexPath];
            
            return cell;
        }else{
            FMDeatilCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentDetailCell forIndexPath:indexPath];
            FMDetailCommentLayoutFrame *layoutFrame = [[FMDetailCommentLayoutFrame alloc]init];
            cell.commentLayoutFrame = layoutFrame;
            return cell;

        }
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) return 40;
        if (indexPath.row == 1) return 65;
        return 40;
    }else if (indexPath.section == 1){
        return 60;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) return 40;
        if (indexPath.row == 1) return COURSE_FM_HEIGHT;
    }else{
        if (indexPath.row == 0) return 50;
        return 70;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
@end
