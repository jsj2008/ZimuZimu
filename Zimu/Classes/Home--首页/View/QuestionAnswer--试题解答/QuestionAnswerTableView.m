//
//  QuestionAnswerTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionAnswerTableView.h"
#import "HeaderTitleCell.h"
#import "QAPreviousQACell.h"
#import "QANiceQuestionCell.h"
#import "QANiceQuestionCellLayout.h"

static NSString *HeaderTitleIdentifier = @"headerTitleCell";
static NSString *QAPreviousQAIdentifier = @"QAPreviousQACell";
static NSString *QANiceQuestionIdentifier = @"QANiceQuestionCell";
@interface QuestionAnswerTableView ()<UITableViewDelegate,UITableViewDataSource>{
    NSArray *_demoArray;
}

@end

@implementation QuestionAnswerTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        _demoArray = @[@YES,@NO,@YES,@NO];

        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:HeaderTitleIdentifier];
        [self registerNib:[UINib nibWithNibName:@"QAPreviousQACell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QAPreviousQAIdentifier];
        [self registerNib:[UINib nibWithNibName:@"QANiceQuestionCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:QANiceQuestionIdentifier];

    }
    return self;
}

//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
    }else{
        return _demoArray.count + 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderTitleIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"往期试题解答精选";
            cell.imageString = @"home_zhuanlandingyue_icon";
            
            return cell;
        }
        QAPreviousQACell *cell = [tableView dequeueReusableCellWithIdentifier:QAPreviousQAIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:HeaderTitleIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"本期提问精选";
            cell.imageString = @"home_meiwentuijian_icon";
            
            return cell;
        }
        QANiceQuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:QANiceQuestionIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        BOOL hasQiestionImage = [_demoArray[indexPath.row - 1] boolValue];
        QANiceQuestionCellLayout *layout = [[QANiceQuestionCellLayout alloc]initWithQuestionImage:hasQiestionImage];
        cell.QANiceQuestionCellLayout = layout;
        
        return cell;
    }
}

//delegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0 ) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0){
        if (indexPath.row == 0) {
            return 44;
        }
        return 40;
    }else{
        if (indexPath.row == 0) {
            return 44;
        }
        BOOL hasQiestionImage = [_demoArray[indexPath.row - 1] boolValue];
        QANiceQuestionCellLayout *layout = [[QANiceQuestionCellLayout alloc]initWithQuestionImage:hasQiestionImage];
        if (indexPath.row == _demoArray.count) {
            return layout.cellHeight - 10;      //最后一行不需要分割线
        }
        return layout.cellHeight;
    }
}

@end
