//
//  OpenCourseTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OpenCourseTableView.h"
#import "HeaderTitleCell.h"
#import "OpenCourseVideoCell.h"
#import "ExamFreeFMCell.h"

static NSString *headerTitleIdentifier = @"headerTitleCell";
static NSString *openCourseVideoIdentifier = @"openCourseVideoCell";
static NSString *examFreeFMIdentifier = @"examFreeFMCell";

@interface OpenCourseTableView ()<UITableViewDelegate, UITableViewDataSource>


@end
@implementation OpenCourseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"HeaderTitleCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:headerTitleIdentifier];
        [self registerNib:[UINib nibWithNibName:@"OpenCourseVideoCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:openCourseVideoIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ExamFreeFMCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:examFreeFMIdentifier];

        
    }
    return self;
}

//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"考试视频 | 免费";
            cell.imageString = @"home_mianfeishipin_icon";
            
            return cell;
        }
        OpenCourseVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:openCourseVideoIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageArray = @[@"home_FM1",@"home_FM2",@"home_FM3",@"home_FM1"];
        
        return cell;
    }else{
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.titleString = @"FM课程 | 免费";
            cell.imageString = @"home_FM_icon";
            
            return cell;
        }
        ExamFreeFMCell *cell = [tableView dequeueReusableCellWithIdentifier:examFreeFMIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageString = [NSString stringWithFormat:@"home_FM%li",indexPath.row];
        
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

    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 44;
        }
        CGFloat width = (self.width - 30)/2.0;
        CGFloat height = (width * 0.7 + 60) * 2 + 30;
        return height;
    }else{
        if (indexPath.row == 0) {
            return 44;
        }
        return 80;
    }
}
@end
