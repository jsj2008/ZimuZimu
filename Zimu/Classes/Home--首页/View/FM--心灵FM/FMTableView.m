//
//  FMTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMTableView.h"
#import "FMDetailHotCell.h"
#import "FMDetailIntroCell.h"
#import "FMDetailAuthorCell.h"
#import "FMDetailOtherFMHeaderCell.h"
#import "FMDetailOtherFMCell.h"
#import "FMDetailCommentHeaderCell.h"
#import "FMDeatilCommentCell.h"
#import "FMDetailIntroLayoutFrame.h"
#import "FMDetailCommentLayoutFrame.h"

static NSString *hotCellIdentifier = @"FMDetailHotCell";
static NSString *introCellIdentifier = @"FMDetailIntroCell";
static NSString *authorCellIdentifier = @"FMDetailAuthorCell";
static NSString *otherFMHeaderCellIdentifier = @"FMDetailOtherFMHeaderCell";
static NSString *otherFMCellIdentifier = @"FMDetailOtherFMCell";
static NSString *commentHeaderIdentifier = @"FMDetailCommentHeaderCell";
static NSString *commentIdentifier = @"FMDetailCommentCell";

@interface FMTableView ()<UITableViewDelegate, UITableViewDataSource, FMDetailIntroCellDelegate>{
    FMDetailIntroLayoutFrame *_introLayoutFrame;
    BOOL _introCellIsOpening;      //内容cell是否已展开
}

@end

@implementation FMTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = themeGray;
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        _introCellIsOpening = NO;
        
        //注册单元格
        [self registerNib:[UINib nibWithNibName:@"FMDetailHotCell" bundle:nil] forCellReuseIdentifier:hotCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailIntroCell" bundle:nil] forCellReuseIdentifier:introCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailAuthorCell" bundle:nil] forCellReuseIdentifier:authorCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailOtherFMHeaderCell" bundle:nil] forCellReuseIdentifier:otherFMHeaderCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailOtherFMCell" bundle:nil] forCellReuseIdentifier:otherFMCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailCommentHeaderCell" bundle:nil] forCellReuseIdentifier:commentHeaderIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDeatilCommentCell" bundle:nil] forCellReuseIdentifier:commentIdentifier];
    }
    return self;
}

//DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 3) {
        return 3;
    }else if (section == 4){
        return 5;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        FMDetailHotCell *cell = [tableView dequeueReusableCellWithIdentifier:hotCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        return cell;
    }else if (indexPath.section == 1){
        FMDetailIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:introCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        cell.introLayoutFrame = _introLayoutFrame;
        if (_introCellIsOpening) {
            //已展开
            cell.imageString = @"FM_close";
        }else{
            //未展开
            cell.imageString = @"FM_open";
        }
        
        return cell;
    }else if (indexPath.section == 2){
        FMDetailAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:authorCellIdentifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            FMDetailOtherFMHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:otherFMHeaderCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
        }else{
            FMDetailOtherFMCell *cell = [tableView dequeueReusableCellWithIdentifier:otherFMCellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
        }
    }else{
        if (indexPath.row == 0) {
            FMDetailCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:commentHeaderIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            
            return cell;
        }else{
            FMDeatilCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            FMDetailCommentLayoutFrame *layoutFrame = [[FMDetailCommentLayoutFrame alloc]init];
            cell.commentLayoutFrame = layoutFrame;
            
            return cell;
        }
    }
}

//Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 45/375.0 * kScreenWidth;
    }else if (indexPath.section == 1){
        _introLayoutFrame = [[FMDetailIntroLayoutFrame alloc]init];
        _introLayoutFrame.isOpening = _introCellIsOpening;
        return _introLayoutFrame.cellHeight;
    }else if (indexPath.section == 2){
        return 60/375.0 * kScreenWidth;
    }else if (indexPath.section == 3){
        if (indexPath.row == 0) {
            return 40;
        }else{
            return 100/375.0 * kScreenWidth;
        }
    }else{
        if (indexPath.row == 0) {
            return 50;
        }else{
            FMDetailCommentLayoutFrame *layoutFrame = [[FMDetailCommentLayoutFrame alloc]init];
            return layoutFrame.cellHeight;
        }
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

#pragma mark - FMDetailIntroCellDelegate
- (void)openCellContentLayout{
    _introCellIsOpening = !_introCellIsOpening;
    [self reloadData];
}




@end
