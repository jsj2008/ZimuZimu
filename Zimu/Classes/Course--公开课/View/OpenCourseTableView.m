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

static NSString *headerTitleIdentifier = @"headerTitleCell";
static NSString *openCourseVideoIdentifier = @"openCourseVideoCell";

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

        
    }
    return self;
}

//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row == 0) {
            HeaderTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:headerTitleIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if (indexPath.section == 0) cell.titleString = @"最新";
            else if (indexPath.section == 1) cell.titleString = @"免费";
            else if (indexPath.section == 2) cell.titleString = @"热销";
            
            return cell;
        }
        OpenCourseVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:openCourseVideoIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageArray = @[@"activity_list1",@"home_FM1",@"home_FM2",@"home_FM3",@"home_FM1"];
        
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 35;
    }
    CGFloat width = (self.width - 30)/2.0;
    CGFloat height = ((width * 0.5 + 40) * 2) + ((kScreenWidth - 20) * 0.5 + 38) + 40;
    return height;
}
@end
