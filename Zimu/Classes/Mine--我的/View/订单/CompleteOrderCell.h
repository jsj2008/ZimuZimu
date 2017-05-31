//
//  CompleteOrderCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderModel.h"

@class CompleteOrderCell;
@protocol CompleteOrderCellDelegate <NSObject>

//删除订单
- (void)completeOrderCellDeleteOrder:(CompleteOrderCell *)cell;

@end

@interface CompleteOrderCell : UITableViewCell

@property (nonatomic, strong) OrderModel *orderModel;

@property (nonatomic, weak) id<CompleteOrderCellDelegate> delegate;


@end
