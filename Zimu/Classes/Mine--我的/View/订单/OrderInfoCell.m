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
    NSInteger createTimestamp = [orderModel.createTime integerValue];
    _creatTimeLabel.text = [NSString stringWithFormat:@"创建时间：%@",[self handleDateWithTimeStamp:createTimestamp]];
    
    //付款时间
    NSInteger status  =[_orderModel.status integerValue];
    if (status == 1) {
        NSInteger payTimestamp = [orderModel.payTime integerValue];
        _payTimeLabel.text = [NSString stringWithFormat:@"付款时间：%@",[self handleDateWithTimeStamp:payTimestamp]];
    }else if (status == 0){
        _payTimeLabel.text = [NSString stringWithFormat:@"付款时间：未付款"];
    }
}

- (NSString *)handleDateWithTimeStamp:(NSInteger)timeStamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp/1000.0];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}


@end
