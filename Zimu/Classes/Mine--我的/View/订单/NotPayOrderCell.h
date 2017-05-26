//
//  NotPayOrderCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@class NotPayOrderCell;
@protocol NotPayOrderCellDelegate <NSObject>

//付款
- (void)notPayOrderCellToPay:(NotPayOrderCell *)cell;

//删除订单
- (void)notPayOrderCellDeleteOrder:(NotPayOrderCell *)cell;

@end

@interface NotPayOrderCell : UITableViewCell

@property (nonatomic, strong) OrderModel *orderModel;

@property (nonatomic, weak) id<NotPayOrderCellDelegate> delegate;

@end
