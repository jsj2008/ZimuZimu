//
//  NotPayOrderCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NotPayOrderCell.h"
//#import "UIView+SnailUse.h"
//#import "PaymentChannelView.h"
//#import "SnailQuickMaskPopups.h"
#import <UIImageView+WebCache.h>

@interface NotPayOrderCell ()
@property (weak, nonatomic) IBOutlet UIButton *orderTypeButton;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
- (IBAction)cancelButtonAction:(UIButton *)sender;
- (IBAction)payButtonAction:(UIButton *)sender;

//@property (nonatomic, strong) SnailQuickMaskPopups *popup;
//@property (nonatomic, strong) PaymentChannelView *paymentChannelView;

@end

@implementation NotPayOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
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
    if ([self.delegate respondsToSelector:@selector(notPayOrderCellDeleteOrder:)]) {
        [self.delegate notPayOrderCellDeleteOrder:self];
    }
}

- (IBAction)payButtonAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(notPayOrderCellToPay:)]) {
        [self.delegate notPayOrderCellToPay:self];
    }
    
//    OrderOfflineCourseModel *orderCourseModel = _orderModel.offlineCourse;
//    NSDictionary *modelDic = @{@"title":orderCourseModel.courseName,
//                               @"courseId":_orderModel.offCourseId,
//                               @"price":_orderModel.orderPrice,
//                               @"time":@"",
//                               @"address":@""};
//    PaymentInfoModel *paymentInfoModel = [PaymentInfoModel yy_modelWithDictionary:modelDic];
//    _paymentChannelView = [UIView paymentChannelView];
////    _paymentChannelView.delegate = self;
//    _paymentChannelView.paymentInfoModel = paymentInfoModel;
//    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:_paymentChannelView];
//    _popup.isAllowPopupsDrag = YES;
//    _popup.dampingRatio = 0.9;
//    _popup.presentationStyle = PresentationStyleBottom;
//    [_popup presentAnimated:YES completion:nil];

}


- (void)setOrderModel:(OrderModel *)orderModel{
    _orderModel = orderModel;
    //订单类型
    [_orderTypeButton setTitle:@"线下课程" forState:UIControlStateNormal];
    
    //已完成
    _stateLabel.text = @"待付款";
    
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
