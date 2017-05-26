//
//  OrderDetailTableView.h
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@interface OrderDetailTableView : UITableView

@property (nonatomic, strong) OrderModel *orderModel;

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style orderModel:(OrderModel *)orderModel;

@end
