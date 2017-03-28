//
//  FindListTableView.m
//  Zimu
//
//  Created by apple on 2017/3/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindListTableView.h"
#import "NSString+YFString.h"
#import "WXLabel.h"

#import "FindHeadCell.h"
#import "FindListActCell.h"
#import "FindAskTextCell.h"
#import "FindTopicCell.h"
#import "FindArticleCell.h"
#import "FindCenterTitleCell.h"

#import "FindHotTopicListCollectiomView.h"
#import "FindFunctionView.h"

static NSString *headCellId = @"findHCId";
static NSString *actCellId = @"findActId";
static NSString *askCellId = @"findAskId";
static NSString *artCellId = @"findArtId";
static NSString *cenCellId = @"findCenId";
static NSString *nullCell = @"findNullid";
static NSString *topicCellId = @"findTopicId";

@interface FindListTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) FindHotTopicListCollectiomView *topicView;
@property (nonatomic, strong) FindFunctionView *functionView;

@property (nonatomic, strong) NSArray *textTest;

@end

@implementation FindListTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        //注册单元格
        NSBundle *bundle = [NSBundle mainBundle];
        UINib *nib0 = [UINib nibWithNibName:@"FindHeadCell" bundle:[NSBundle mainBundle]];
        [self registerNib:nib0 forCellReuseIdentifier:headCellId];
        
        UINib *nib1 = [UINib nibWithNibName:@"FindListActCell" bundle:bundle];
        [self registerNib:nib1 forCellReuseIdentifier:actCellId];
        
        UINib *nib2 = [UINib nibWithNibName:@"FindAskTextCell" bundle:bundle];
        [self registerNib:nib2 forCellReuseIdentifier:askCellId];
        
        UINib *nib3 = [UINib nibWithNibName:@"FindArticleCell" bundle:bundle];
        [self registerNib:nib3 forCellReuseIdentifier:artCellId];
        
        UINib *nib4 = [UINib nibWithNibName:@"FindCenterTitleCell" bundle:bundle];
        [self registerNib:nib4 forCellReuseIdentifier:cenCellId];
        
        UINib *nib5 = [UINib nibWithNibName:@"FindTopicCell" bundle:bundle];
        [self registerNib:nib5 forCellReuseIdentifier:topicCellId];
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:nullCell];
        //设置数据源和代理
        self.dataSource = self;
        self.delegate = self;
        
        self.backgroundColor = themeGray;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _textTest = @[@"请问欧福军我", @"请问欧福军我们都知道利用XIB可以很轻松的设置一个label为自适应高度，但如果将一个label放在tableviewcell上面，并且这个cell还想用XIB描述，这个时候就需要先确定label的高度再确定cell的高度，最后才能显示福军我们都知道利用Xasgaasdgadfgkhjakerhng   iugI"];
    }
    return self;
}

#pragma mark - 代理和数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 2;
            break;
        case 4:
            return 3;
            break;
        case 5:
            return 3;
            break;
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {   //热门话题
        if (indexPath.row == 0) {
            FindHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellId forIndexPath:indexPath];
            cell.titleLabel.text = @"热门话题";
            return cell;
        }else{
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nullCell forIndexPath:indexPath];
            if (!_topicView) {
                UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
                flowLayout.minimumLineSpacing = 10;
                flowLayout.minimumInteritemSpacing = 10;
                flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
                
                _topicView = [[FindHotTopicListCollectiomView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90) collectionViewLayout:flowLayout];
            }
            [cell addSubview:_topicView];
            return cell;
        }
    }else if (indexPath.section == 1){      //我参与的话题
        if (indexPath.row == 0) {
            FindCenterTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cenCellId forIndexPath:indexPath];
            cell.centerTitleLabel.text = @"我参与的话题讨论";
            cell.centerTitleLabel.textColor = [UIColor colorWithHexString:@"666666"];
            cell.backgroundColor = themeGray;
            return cell;
        }else if (indexPath.row == 1){
            FindTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellId forIndexPath:indexPath];
            cell.titleLabel.text = @"哪一刻你觉得自己快要抑郁的死掉了";
            cell.parNum.text = @"666人参与";
            return cell;
        }else{
            FindCenterTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:cenCellId forIndexPath:indexPath];
            cell.centerTitleLabel.text = @"查看更早参与的话题";
            cell.centerTitleLabel.textColor = [UIColor colorWithHexString:@"999999"];
            cell.backgroundColor = themeWhite;
            return cell;
        }
    }else if (indexPath.section == 2){      //功能按钮
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:nullCell forIndexPath:indexPath];
        if (!_functionView) {
            UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
            flowLayout.minimumLineSpacing = 0;
            flowLayout.minimumInteritemSpacing = 0;
            flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            
            _functionView = [[FindFunctionView alloc] initWithFrame:CGRectMake(14.5, 0, kScreenWidth - 29, (kScreenWidth - 29) / 8 + 45) collectionViewLayout:flowLayout];
        }
        [cell addSubview:_functionView];
        return cell;
    }else if (indexPath.section == 3){     //活动推荐
        if (indexPath.row == 0) {
            FindHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellId forIndexPath:indexPath];
            cell.titleLabel.text = @"活动推荐";
            return cell;
        }else{
            FindListActCell *cell = [tableView dequeueReusableCellWithIdentifier:actCellId forIndexPath:indexPath];
            cell.titleLabe.text = @"看**报名参加了本场活动";
            return cell;
        }
    }else if (indexPath.section == 4){     //问答排行
        if (indexPath.row == 0) {
            FindHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellId forIndexPath:indexPath];
            cell.titleLabel.text = @"问答排行";
            return cell;
        }else{
            FindAskTextCell *cell = [tableView dequeueReusableCellWithIdentifier:askCellId forIndexPath:indexPath];
            NSString *str = _textTest[indexPath.row - 1];
            NSAttributedString *attrString = [NSString getAttributedStringWithString:str lineSpace:1.5];
            cell.askDetail.attributedText = attrString;
//            cell.askDetail.text = str;
            return cell;
        }
    }else{                                 //文章排行
        if (indexPath.row == 0) {
            FindHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:headCellId forIndexPath:indexPath];
            cell.titleLabel.text = @"文章排行";
            return cell;
        }else{
            FindArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:artCellId forIndexPath:indexPath];
            
            return cell;
        }

    }

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {   //热门话题
        if (indexPath.row == 0) {
            return 44;
        }else{
            return 92;
        }
    }else if (indexPath.section == 1){      //我参与的话题
        if (indexPath.row == 0) {
            return 32;
        }else if (indexPath.row == 1){
            return 85;
        }else{
            return 35;
        }
    }else if (indexPath.section == 2){      //功能按钮
        return (kScreenWidth - 29) / 8 + 45;
    }else if (indexPath.section == 3){     //活动推荐
        if (indexPath.row == 0) {
            return 44;
        }else{
#pragma mark - 计算活动cell高度
            CGFloat actHeight = (kScreenWidth - 20) * 28 / 71 + 44;
            return actHeight;
        }
    }else if (indexPath.section == 4){     //问答排行
        if (indexPath.row == 0) {
            return 44;
        }else{
#pragma mark - 要计算cell的高度
            CGFloat orginalH = 113;
            NSString *content = _textTest[indexPath.row - 1];
            CGFloat height = [WXLabel getTextHeight:14.0 width:kScreenWidth - 20 text:content linespace:1.5];
            
            CGFloat trueH = orginalH + height;
            if (trueH > 113 + 90 ) {
                trueH = 113 + 90;
            }
            return trueH;       //这个高度需要计算
        }
    }else{                                 //文章排行
        if (indexPath.row == 0) {
            return 44;
        }else{
#pragma mark - 计算文章cell高度
            CGFloat articleHeight = (kScreenWidth - 20) * 14 / 37 + 140;
            return articleHeight;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }else if (section == 1){
        return 0;
    }else if (section == 2){
        return 10;
    }else if (section == 3){
        return 10;
    }else if (section == 4){
        return 10;
    }else{
        return 5;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    return v;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"===== %zd ===== %zd", indexPath.section, indexPath.row);
}
@end
