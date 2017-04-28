//
//  ExpertListTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertListTableView.h"

@interface ExpertListTableView ()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation ExpertListTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}




@end
