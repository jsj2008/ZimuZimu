//
//  OrderDetailTableView.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OrderDetailTableView.h"
#import "OrderTypeCell.h"
#import "CustomerInfoCell.h"
#import "ProductInfoCell.h"
#import "OrderInfoCell.h"

static NSString *orderTypeCellIdentifier = @"OrderTypeCell";
static NSString *customerInfoCellIdentifier = @"CustomerInfoCell";
static NSString *productInfoCellIdentifier = @"ProductInfoCell";
static NSString *orderInfoCellIdentifier = @"OrderInfoCell";

@interface OrderDetailTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation OrderDetailTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style orderModel:(OrderModel *)orderModel{
    self = [super initWithFrame:frame style:style];
    if (self) {
        
        _orderModel = orderModel;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerNib:[UINib nibWithNibName:@"OrderTypeCell" bundle:nil] forCellReuseIdentifier:orderTypeCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"CustomerInfoCell" bundle:nil] forCellReuseIdentifier:customerInfoCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"ProductInfoCell" bundle:nil] forCellReuseIdentifier:productInfoCellIdentifier];
        [self registerNib:[UINib nibWithNibName:@"OrderInfoCell" bundle:nil] forCellReuseIdentifier:orderInfoCellIdentifier];
        
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor clearColor];
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
    if (indexPath.section == 0) {
        OrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:orderTypeCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.status = [_orderModel.status integerValue];
        
        return cell;
    }else if (indexPath.section == 1){
        CustomerInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:customerInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderUserModel = _orderModel.user;
        
        return cell;
    }else if (indexPath.section == 2){
        ProductInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:productInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderModel = _orderModel;
        
        return cell;
    }else{
        OrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:orderInfoCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderModel = _orderModel;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }else if (indexPath.section == 1){
        return 80;
    }else if (indexPath.section == 2){
        return 160;
    }else{
        return 105;
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






@end
