//
//  OrderInfoCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OrderInfoCell.h"

@interface OrderInfoCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTimeLabel;


@end

@implementation OrderInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    
    //订单编号
    _orderNumLabel.text = [NSString stringWithFormat:@"订单编号：%@",orderModel.orderId];
    
    //创建时间
    _creatTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",orderModel.createTime];
    
    //付款时间
    NSInteger status  =[_orderModel.status integerValue];
    if (status == 1) {
        _payTimeLabel.text = [NSString stringWithFormat:@"付款时间：%@",orderModel.payTime];
    }else if (status == 0){
        _payTimeLabel.text = [NSString stringWithFormat:@"付款时间：未付款"];
    }
}


@end
