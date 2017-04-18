//
//  PaymentChannelView.m
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "PaymentChannelView.h"
#import "PaymentChannelTableView.h"

@interface PaymentChannelView ()<PaymentChannelDelegate>

@property (nonatomic, strong) PaymentChannelTableView *paymentChannelTableView;
@property (nonatomic, strong) UIButton *payButton;
@property (nonatomic, assign) BOOL selectedChannel;     //是否已选择支付方式

@end

@implementation PaymentChannelView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _selectedChannel = NO;
        self.backgroundColor = themeWhite;
        [self addSubview:self.paymentChannelTableView];
        [self addSubview:self.payButton];
    }
    return self;
}

- (PaymentChannelTableView *)paymentChannelTableView{
    if (!_paymentChannelTableView) {
        _paymentChannelTableView = [[PaymentChannelTableView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height - 49) style:UITableViewStylePlain];
        _paymentChannelTableView.scrollEnabled = NO;
        _paymentChannelTableView.channelDelegate = self;
    }
    return _paymentChannelTableView;
}

//PaymentChannelDelegate
- (void)selectPaymentChannel:(NSString *)channel{
    NSLog(@"%@",channel);
    _selectedChannel = YES;
    [_payButton setBackgroundColor:themeYellow];
    _payButton.enabled = YES;
}

- (UIButton *)payButton{
    if (!_payButton) {
        _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _payButton.frame = CGRectMake(0, self.height - 49, self.width, 49);
        [_payButton setBackgroundColor:[UIColor colorWithHexString:@"999999"]];
        _payButton.enabled = NO;
        NSString *titleString = @"确认支付 ￥1.00";
        NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc]initWithString:titleString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:themeWhite}];
        [titleAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(5, titleString.length - 5)];
        [_payButton setAttributedTitle:titleAttributedString forState:UIControlStateNormal];
        [_payButton addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    }
    return _payButton;
}

/**
 *  支付
 */
- (void)pay{
    NSLog(@"pay : %@",_paymentChannelTableView.channel);
}

- (void)setPrice:(NSString *)price{
    if (_price != price) {
        _price = price;
        NSString *titleString = [NSString stringWithFormat:@"确认支付 ￥%@",price];//@"确认支付 ￥1.00";
        NSMutableAttributedString *titleAttributedString = [[NSMutableAttributedString alloc]initWithString:titleString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:themeWhite}];
        [titleAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(5, titleString.length - 5)];
        [_payButton setAttributedTitle:titleAttributedString forState:UIControlStateNormal];
        
    }
}



@end
