//
//  HomeVideoDeatilView.m
//  Zimu
//
//  Created by apple on 2017/3/2.
//  Copyright © 2017年 Zimu. All rights reserved.


//用到了 VideoDetailTitleCell  VideoDetailTextCell  VideoDetailToolCell SubscreibeReadFreeHeadCell FMDetailCommentHeaderCell  FMDeatilCommentCell
//

#import "HomeVideoDeatilView.h"
#import "FMIntroCell.h"
#import "FMIntroCellLayoutFrame.h"
#import "FMAuthorCell.h"
#import "FMAuthorCellLayoutFrame.h"

#import "HotCourseHeadCell.h"
#import "CourseHotListView.h"

#import "FMCommentHeaderCell.h"
#import "FMCommentTableViewCell.h"
#import "FMCommentCellLayoutFrame.h"

static NSString *introIdentifier = @"FMIntroCell";              //视频介绍
static NSString *authorIdentifier = @"FMAuthorCell";            //作者cell
static NSString *headCellIdentifier = @"HotCourseHeadCell";               //推荐课程
static NSString *normalCell = @"videoDetailCellNormal";         //普通

static NSString *headerIdentifier = @"FMCommentHeaderCell";
static NSString *commentIdentifier = @"FMCommentTableViewCell";

#define COURSE_FM_HEIGHT        kScreenWidth * 0.214 + 60

@interface HomeVideoDeatilView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)CourseHotListView *hotListView;

@end

@implementation HomeVideoDeatilView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:[FMIntroCell class] forCellReuseIdentifier:introIdentifier];
        [self registerClass:[FMAuthorCell class] forCellReuseIdentifier:authorIdentifier];
        
        [self registerClass:[HotCourseHeadCell class] forCellReuseIdentifier:headCellIdentifier];
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:normalCell];
        [self registerClass:[FMCommentHeaderCell class] forCellReuseIdentifier:headerIdentifier];
        [self registerClass:[FMCommentTableViewCell class] forCellReuseIdentifier:commentIdentifier];
        
        self.backgroundColor = themeGray;
        self.separatorColor = themeGray;
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
    if (section == 2) {
        return 2;
    }else if (section == 3){
        return 1 + _videoCommentModelArray.count;
    }else{
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FMIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:introIdentifier];
        FMIntroCellLayoutFrame *layoutFrame = [[FMIntroCellLayoutFrame alloc]initWithVideoDetailModel:_videoDetailModel];
        cell.videolayoutFrame = layoutFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 1){
        FMAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:authorIdentifier forIndexPath:indexPath];
        FMAuthorCellLayoutFrame *layoutFrame = [[FMAuthorCellLayoutFrame alloc]initWithExpertDetailModel:_expertDetailModel];
        cell.dataLayoutFrame = layoutFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            HotCourseHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:normalCell forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (!_hotListView) {
                _hotListView = [[CourseHotListView alloc] initWithFrame:CGRectMake(0, 0, cell.width, (kScreenWidth - 40)/3.0 * 0.8 + 50) collectionViewLayout:[UICollectionViewFlowLayout new]];
                [cell addSubview:_hotListView];
            }
            _hotListView.hotVideoModelArray = _hotVideoModelArray;
            
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            FMCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.commentCount = _videoCommentModelArray.count;
            
            return cell;
        }
        FMCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
        FMCommentCellLayoutFrame *layoutFrame = [[FMCommentCellLayoutFrame alloc]initWithCommentModel:_videoCommentModelArray[indexPath.row - 1]];
        cell.dataCommentLayoutFrame = layoutFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FMIntroCellLayoutFrame *layoutFrame = [[FMIntroCellLayoutFrame alloc]initWithVideoDetailModel:_videoDetailModel];
        return layoutFrame.cellHeight;
    }else if (indexPath.section == 1){
        FMAuthorCellLayoutFrame *layoutFrame = [[FMAuthorCellLayoutFrame alloc]initWithExpertDetailModel:_expertDetailModel];
        return layoutFrame.cellHeight;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) return 35;
        else return COURSE_FM_HEIGHT;
    }else{
        if (indexPath.row == 0) {
            return 35;
        }
        FMCommentCellLayoutFrame *videoLayoutFrame = [[FMCommentCellLayoutFrame alloc]initWithCommentModel:_videoCommentModelArray[indexPath.row - 1]];
        return videoLayoutFrame.cellHeight;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)setVideoDetailModel:(VideoDetailModel *)videoDetailModel{
    _videoDetailModel = videoDetailModel;
    [self reloadData];
}

- (void)setExpertDetailModel:(ExpertDetailModel *)expertDetailModel{
    _expertDetailModel = expertDetailModel;
    [self reloadData];
}

- (void)setHotVideoModelArray:(NSArray *)hotVideoModelArray{
    _hotVideoModelArray = hotVideoModelArray;
    
    [self reloadData];
}

- (void)setVideoCommentModelArray:(NSArray *)videoCommentModelArray{
    _videoCommentModelArray = videoCommentModelArray;
    
    [self reloadSections:[NSIndexSet indexSetWithIndex:3] withRowAnimation:UITableViewRowAnimationFade];
}


@end
