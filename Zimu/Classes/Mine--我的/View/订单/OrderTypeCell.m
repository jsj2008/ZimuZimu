//
//  OrderTypeCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OrderTypeCell.h"
#import "SnailQuickMaskPopups.h"
#import "UIView+SnailUse.h"
#import "CallPhoneView.h"

@interface OrderTypeCell ()<CallPhoneViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactButton;       //联系客服

@property (nonatomic, strong) SnailQuickMaskPopups *popups;

- (IBAction)contactButtonAction:(UIButton *)sender;

@end

@implementation OrderTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//联系客服
- (IBAction)contactButtonAction:(UIButton *)sender {
    CallPhoneView *view = [UIView callPhoneView];
//    view.phoneString = @"10086";
    view.delegate = self;
    _popups = [SnailQuickMaskPopups popupsWithMaskStyle:MaskStyleBlackTranslucent aView:view];
    _popups.isAllowPopupsDrag = YES;
    _popups.dampingRatio = 0.9;
    _popups.presentationStyle = PresentationStyleBottom;
    [_popups presentAnimated:YES completion:nil];
    
}

//CallPhoneViewDelegate
- (void)callPhoneViewDidClickClose{
    [_popups dismissAnimated:YES completion:nil];
}

- (void)setStatus:(NSInteger)status{
    if (status == 0) {
        //待付款
        _stateLabel.text = @"待付款";
    }else if (status == 1){
        //订单完成
        _stateLabel.text = @"交易完成";
    }
}

@end
