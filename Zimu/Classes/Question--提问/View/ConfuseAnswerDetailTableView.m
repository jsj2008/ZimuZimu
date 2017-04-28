//
//  ConfuseAnswerDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ConfuseAnswerDetailTableView.h"
#import "ConfuseTagCell.h"
#import "ConfuseContentCell.h"
#import "ConfuseContentCellLayoutFrame.h"
#import "ConfuseExpertAnswerCell.h"
#import "ExpertAnswerLayoutFrame.h"
#import "HeaderTitleCell.h"
#import "FMDetailCommentHeaderCell.h"
#import "FMDeatilCommentCell.h"
#import "FMDetailCommentLayoutFrame.h"

static NSString *confuseTagIdentifier = @"ConfuseTagCell";
static NSString *confuseContentCellIdentifier = @"ConfuseContentCell";
static NSString *expertAnswerCellIdentifier = @"ConfuseExpertAnswerCell";
static NSString *headerTitleCellIdentifier = @"headerTitleCell";
static NSString *commentHeaderIdentifier = @"FMDetailCommentHeaderCell";
static NSString *commentIdentifier = @"FMDetailCommentCell";

@interface ConfuseAnswerDetailTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation ConfuseAnswerDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self hideExtraLines];
        self.backgroundColor = themeGray;
        
        [self registerNib:[UINib nibWithNibName:@"ConfuseTagCell" bundle:nil] forCellReuseIdentifier:confuseTagIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ConfuseContentCell" bundle:nil] forCellReuseIdentifier:confuseContentCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ConfuseExpertAnswerCell" bundle:nil] forCellReuseIdentifier:expertAnswerCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:nil] forCellReuseIdentifier:headerTitleCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDetailCommentHeaderCell" bundle:nil] forCellReuseIdentifier:commentHeaderIdentifier];
        [self registerNib:[UINib nibWithNibName:@"FMDeatilCommentCell" bundle:nil] forCellReuseIdentifier:commentIdentifier];
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 6;
    }
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ConfuseTagCell *cell = [tableView dequeueReusableCellWithIdentifier:confuseTagIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 0, 0, 0);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.tagArray = @[@"亲子关系",@"叛逆",@"网瘾少年"];
            
            return cell;
        }
        ConfuseContentCell *cell = [tableView dequeueReusableCellWithIdentifier:confuseContentCellIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleCellIdentifier];
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, 0, 0, cell.width);
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"专家解读";
            
            return cell;
        }
        ConfuseExpertAnswerCell *cell = [tableView dequeueReusableCellWithIdentifier:expertAnswerCellIdentifier];
        cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        ExpertAnswerLayoutFrame *layoutFrame = [[ExpertAnswerLayoutFrame alloc]init];
        cell.layoutFrame = layoutFrame;
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            FMDetailCommentHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:commentHeaderIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(self.height - 1, cell.width - 0.5, 0, 0);
            
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
            return 45;
        }
        ConfuseContentCellLayoutFrame *layoutFrame = [[ConfuseContentCellLayoutFrame alloc]init];
        return layoutFrame.cellHeight;
        
    }else if(indexPath.section == 1){
        if (indexPath.row == 0) {
            return 45;
        }
        ExpertAnswerLayoutFrame *layoutFrame = [[ExpertAnswerLayoutFrame alloc]init];
        return layoutFrame.cellHeight;
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
    if (section == 2) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}



- (void)hideExtraLines{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = themeWhite;
    self.tableFooterView = view;
}
@end
