//
//  ProductInfoCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ProductInfoCell.h"
#import <UIImageView+WebCache.h>

@interface ProductInfoCell ()

@property (weak, nonatomic) IBOutlet UIButton *orderTypeButton;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;


@end



@implementation ProductInfoCell

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


- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    
    //订单类型
    [_orderTypeButton setTitle:@"线下课程" forState:UIControlStateNormal];

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


