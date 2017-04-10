//
//  BookCourseCommentTableViewController.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookCourseCommentTableViewController.h"
#import "BookInfoCell.h"
#import "FMDetailIntroCell.h"
#import "FMDetailIntroCell.h"
#import "FMDetailAuthorCell.h"
#import "FMDetailOtherFMHeaderCell.h"
#import "FMDetailOtherFMCell.h"
#import "FMDetailCommentHeaderCell.h"
#import "FMDeatilCommentCell.h"
#import "FMDetailIntroLayoutFrame.h"
#import "FMDetailCommentLayoutFrame.h"

static NSString *infoIdentifier = @"BookInfoCell";
static NSString *introCellIdentifier = @"FMDetailIntroCell";
static NSString *authorCellIdentifier = @"FMDetailAuthorCell";
static NSString *otherFMHeaderCellIdentifier = @"FMDetailOtherFMHeaderCell";
static NSString *otherFMCellIdentifier = @"FMDetailOtherFMCell";
static NSString *commentHeaderIdentifier = @"FMDetailCommentHeaderCell";
static NSString *commentIdentifier = @"FMDetailCommentCell";

@interface BookCourseCommentTableViewController ()<FMDetailIntroCellDelegate>{
    FMDetailIntroLayoutFrame *_introLayoutFrame;
    BOOL _introCellIsOpening;      //内容cell是否已展开
}


@end

@implementation BookCourseCommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self registerCells];
}

- (void)registerCells{
    [self.tableView registerNib:[UINib nibWithNibName:@"BookInfoCell" bundle:nil] forCellReuseIdentifier:infoIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDetailIntroCell" bundle:nil] forCellReuseIdentifier:introCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDetailAuthorCell" bundle:nil] forCellReuseIdentifier:authorCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDetailOtherFMHeaderCell" bundle:nil] forCellReuseIdentifier:otherFMHeaderCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDetailOtherFMCell" bundle:nil] forCellReuseIdentifier:otherFMCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDetailCommentHeaderCell" bundle:nil] forCellReuseIdentifier:commentHeaderIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:@"FMDeatilCommentCell" bundle:nil] forCellReuseIdentifier:commentIdentifier];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) return 2;
    else if (section == 1) return 1;
    else if (section == 2) return 3;
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            BookInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoIdentifier forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(cell.height - 1.0f, 10, 0, 0);

            return cell;
        }
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
    }else if (indexPath.section == 1){
        FMDetailAuthorCell *cell = [tableView dequeueReusableCellWithIdentifier:authorCellIdentifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
    }else if (indexPath.section == 2){
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 200/375.0 * kScreenWidth;
        }
        _introLayoutFrame = [[FMDetailIntroLayoutFrame alloc]init];
        _introLayoutFrame.isOpening = _introCellIsOpening;
        return _introLayoutFrame.cellHeight;
    }else if (indexPath.section == 1){
        return 60/375.0 * kScreenWidth;
    }else if (indexPath.section == 2){
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section == 3) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


#pragma mark - FMDetailIntroCellDelegate
- (void)openCellContentLayout{
    _introCellIsOpening = !_introCellIsOpening;
    [self.tableView reloadData];
}



@end
