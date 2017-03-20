//
//  ListenHeartTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListenHeartTableView.h"
#import "PouroutCell.h"
#import "ListenHeartDanmuCell.h"
#import "ListenHeartTutorCell.h"
//#import "DanmuCell.h"

static NSString *pouroutCellIdentifier = @"pouroutCell";
static NSString *listenHeartTutorIdentifier = @"listenHeartTutorCell";
static NSString *listenHeartDanmuIdentifier = @"listenHeartDanmuCell";
//static NSString *danmuIdentifier = @"danmuCell";
@interface ListenHeartTableView ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ListenHeartTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"PouroutCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:pouroutCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ListenHeartTutorCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:listenHeartTutorIdentifier];
        [self registerClass:[ListenHeartDanmuCell class] forCellReuseIdentifier:listenHeartDanmuIdentifier];
//        [self registerClass:[DanmuCell class] forCellReuseIdentifier:danmuIdentifier];

    }
    return self;
}

//dataSourse
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else if (section == 1){
        return 1;
    }else{
        return 3;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        PouroutCell *cell = [tableView dequeueReusableCellWithIdentifier:pouroutCellIdentifier];
        cell.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        return cell;
    }else if (indexPath.section == 1){
        ListenHeartDanmuCell *cell = [tableView dequeueReusableCellWithIdentifier:listenHeartDanmuIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        ListenHeartTutorCell *cell = [tableView dequeueReusableCellWithIdentifier:listenHeartTutorIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageString = [NSString stringWithFormat:@"home_course%li",indexPath.row + 1];
        
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
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return 100;
    }else{
        return 80;
    }
}



@end
