//
//  FMTableView.m
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMTableView.h"
#import "FMAuthorCell.h"
#import "FMIntroCell.h"
#import "FMCommentHeaderCell.h"
#import "FMCommentTableViewCell.h"
#import "FMCommentCellLayoutFrame.h"
#import "FMAuthorCellLayoutFrame.h"
#import "FMIntroCellLayoutFrame.h"
#import "UIView+ViewController.h"

static NSString *introIdentifier = @"FMIntroCell";
static NSString *authorIdentifier = @"FMAuthorCell";
static NSString *headerIdentifier = @"FMCommentHeaderCell";
static NSString *commentIdentifier = @"FMCommentTableViewCell";
@interface FMTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation FMTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorColor = themeGray;
        [self registerClass:[FMIntroCell class] forCellReuseIdentifier:introIdentifier];
        [self registerClass:[FMAuthorCell class] forCellReuseIdentifier:authorIdentifier];
        [self registerClass:[FMCommentHeaderCell class] forCellReuseIdentifier:headerIdentifier];
        [self registerClass:[FMCommentTableViewCell class] forCellReuseIdentifier:commentIdentifier];
        
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _fmCommentModelArray.count + 1;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {       //fm介绍
        FMIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:introIdentifier];
        FMIntroCellLayoutFrame *layoutFrame = [[FMIntroCellLayoutFrame alloc]initWithFmDetailModel:_fmDetailModel];
        cell.FMlayoutFrame = layoutFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 1) {
        FMAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:authorIdentifier];
        FMAuthorCellLayoutFrame *layoutFrame = [[FMAuthorCellLayoutFrame alloc]initWithExpertDetailModel:_expertDetailModel];
        cell.dataLayoutFrame = layoutFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            FMCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.commentCount = _fmCommentModelArray.count;
            
            return cell;
        }
        FMCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
        CommentModel *commentModel = _fmCommentModelArray[indexPath.row - 1];
        FMCommentCellLayoutFrame *layoutFrame = [[FMCommentCellLayoutFrame alloc]initWithCommentModel:commentModel];
        cell.dataCommentLayoutFrame = layoutFrame;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FMIntroCellLayoutFrame *layoutFrame = [[FMIntroCellLayoutFrame alloc]initWithFmDetailModel:_fmDetailModel];
        return layoutFrame.cellHeight;
    }else if (indexPath.section == 1) {
        FMAuthorCellLayoutFrame *layoutFrame = [[FMAuthorCellLayoutFrame alloc]initWithExpertDetailModel:_expertDetailModel];
        return layoutFrame.cellHeight;
        
    }else{
        if (indexPath.row == 0) {
            return 35;
        }
        
        CommentModel *commentModel = _fmCommentModelArray[indexPath.row - 1];
        FMCommentCellLayoutFrame *layoutFrame = [[FMCommentCellLayoutFrame alloc]initWithCommentModel:commentModel];
        return layoutFrame.cellHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}


- (void)setFmDetailModel:(FMDetailModel *)fmDetailModel{
    _fmDetailModel = fmDetailModel;
    [self reloadData];
}


- (void)setExpertDetailModel:(ExpertDetailModel *)expertDetailModel{
    _expertDetailModel = expertDetailModel;
    
    [self reloadData];
}

- (void)setFmCommentModelArray:(NSArray *)fmCommentModelArray{
    _fmCommentModelArray = fmCommentModelArray;
    
    [self reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}

@end
