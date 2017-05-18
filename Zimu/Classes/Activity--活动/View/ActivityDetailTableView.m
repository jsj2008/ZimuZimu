//
//  ActivityDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityDetailTableView.h"
#import "ActivityHeaderCell.h"
#import "ActivityProgressCell.h"
#import "ActivityIntroCell.h"
#import "ActivityIntroCellLayoutFrame.h"
#import "ActivityNoteCell.h"

static NSString *headerIdentifier = @"ActivityHeaderCell";
static NSString *progressIdentifier = @"ActivityProgressCell";
static NSString *introIdentifier = @"ActivityIntroCell";
static NSString *noteIdentifier = @"ActivityNoteCell";
@interface ActivityDetailTableView()<UITableViewDelegate, UITableViewDataSource, ActivityIntroCellDelegate>{
    BOOL _introCellIsOpening;
}

@end

@implementation ActivityDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[ActivityHeaderCell class] forCellReuseIdentifier:headerIdentifier];
        [self registerClass:[ActivityProgressCell class] forCellReuseIdentifier:progressIdentifier];
        [self registerClass:[ActivityIntroCell class] forCellReuseIdentifier:introIdentifier];
        [self registerClass:[ActivityNoteCell class] forCellReuseIdentifier:noteIdentifier];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            ActivityHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:headerIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }else{
            ActivityProgressCell*cell = [tableView dequeueReusableCellWithIdentifier:progressIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
    }else if(indexPath.section == 1){
        ActivityIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:introIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        ActivityIntroCellLayoutFrame *layoutFrame = [[ActivityIntroCellLayoutFrame alloc]init];
        layoutFrame.isOpening = _introCellIsOpening;
        cell.isOpening = _introCellIsOpening;
        cell.layoutFrame = layoutFrame;

        return cell;
    }else{
        ActivityNoteCell*cell = [tableView dequeueReusableCellWithIdentifier:noteIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 345 * kScreenWidth/375.0 + 75;
        }else{
            return CGFLOAT_MIN;
        }
    }else if(indexPath.section == 1){
//        return 130;
        ActivityIntroCellLayoutFrame *layoutFrame = [[ActivityIntroCellLayoutFrame alloc]init];
        layoutFrame.isOpening = _introCellIsOpening;
        return layoutFrame.cellHeight;
    }else{
        return 130;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


#pragma mark - ActivityIntroCellDelegate
- (void)openIntroCellLayout{
    _introCellIsOpening = YES;
    [self reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}







@end
