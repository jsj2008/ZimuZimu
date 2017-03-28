//
//  SubscribeLecturerDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeLecturerDetailTableView.h"
#import "SLDTextCell.h"
#import "SLDTextCellLayoutFrame.h"

//static NSString *SLDTitleCellIdentifier = @"SLDTitleCell";
static NSString *SLDTextCellIdentifier = @"SLDTextCell";

@interface SubscribeLecturerDetailTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation SubscribeLecturerDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = themeGray;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerNib:[UINib nibWithNibName:@"SLDTextCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:SLDTextCellIdentifier];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SLDTextCell *cell = [tableView dequeueReusableCellWithIdentifier:SLDTextCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SLDTextCellLayoutFrame *layout = [[SLDTextCellLayoutFrame alloc]init];
    cell.layoutFrame = layout;
    
    return cell;
    
}




@end
