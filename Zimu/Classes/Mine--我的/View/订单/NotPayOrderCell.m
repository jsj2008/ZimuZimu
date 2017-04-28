//
//  NotPayOrderCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NotPayOrderCell.h"
#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"
#import "SnailQuickMaskPopups.h"

@interface NotPayOrderCell ()
@property (weak, nonatomic) IBOutlet UIButton *orderTypeButton;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UIView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *payButton;
- (IBAction)cancelButtonAction:(UIButton *)sender;
- (IBAction)payButtonAction:(UIButton *)sender;

@property (nonatomic, strong) SnailQuickMaskPopups *popup;


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

- (IBAction)cancelButtonAction:(UIButton *)sender {
    
}

- (IBAction)payButtonAction:(UIButton *)sender {
    
    PaymentChannelView *view = [UIView paymentChannelView];
    _popup = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popup.isAllowPopupsDrag = YES;
    _popup.dampingRatio = 0.9;
    _popup.presentationStyle = PresentationStyleBottom;
    [_popup presentAnimated:YES completion:nil];
    
}
@end
