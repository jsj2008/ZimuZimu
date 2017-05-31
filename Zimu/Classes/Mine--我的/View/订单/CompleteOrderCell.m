//
//  CompleteOrderCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CompleteOrderCell.h"
#import <UIImageView+WebCache.h>

@interface CompleteOrderCell ()

@property (weak, nonatomic) IBOutlet UIButton *orderTypeButton;     //订单类型
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;           //订单状态
@property (weak, nonatomic) IBOutlet UIView *contentBGView;         //背景
@property (weak, nonatomic) IBOutlet UIImageView *productImageView; //图片
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;           //标题
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;           //价格
@property (weak, nonatomic) IBOutlet UILabel *countLabel;           //数量
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;      //总价
@property (weak, nonatomic) IBOutlet UIView *seperateLine;          //分割线
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderButton;   //删除订单
- (IBAction)cancelButtonAction:(UIButton *)sender;



@end

@implementation CompleteOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSString *titleString = @"合计：￥300.00";
    NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc]initWithString:titleString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"]}];
    [titleAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 4)];
    _totalPriceLabel.attributedText = titleAttributedString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//删除订单
- (IBAction)cancelButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(completeOrderCellDeleteOrder:)]) {
        [self.delegate completeOrderCellDeleteOrder:self];
    }
}

- (void)setOrderModel:(OrderModel *)orderModel{
    //订单类型
    [_orderTypeButton setTitle:@"线下课程" forState:UIControlStateNormal];
    
    //已完成
    _stateLabel.text = @"订单完成";
    
    //图片
    NSString *imgURL = [imagePrefixURL stringByAppendingString:orderModel.imgUrl];
    [_productImageView sd_setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@""]];
    
    //标题
    OrderOfflineCourseModel *orderOfflineCourseModel = orderModel.offlineCourse;
    _titleLabel.text = orderOfflineCourseModel.courseName;
    
    //价格
    CGFloat totalPrice = [orderModel.orderPrice floatValue];
    _priceLabel.text = [NSString stringWithFormat:@"￥%.2lf",totalPrice];
    
    //合计
    NSString *totalPriceString = [NSString stringWithFormat:@"合计：￥%.2lf",totalPrice];
    NSMutableAttributedString *priceAttributedString = [[NSMutableAttributedString alloc]initWithString:totalPriceString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"333333"]}];
    [priceAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:12] range:NSMakeRange(0, 4)];
    _totalPriceLabel.attributedText = priceAttributedString;
}



@end
