//
//  ActivityOrderFailView.m
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityOrderFailView.h"
#import "WXLabel.h"

@interface ActivityOrderFailView ()

@property (nonatomic, strong) UIButton *returnButton;       //返回按钮
@property (nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *payButton;   //重新支付按钮

@end

@implementation ActivityOrderFailView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}


- (void)makeUI{
    _returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _returnButton.frame = CGRectMake(0, 20, 64, 44);
    [_returnButton setImage:[UIImage imageNamed:@"quxiao"] forState:UIControlStateNormal];
    [_returnButton setImageEdgeInsets:UIEdgeInsetsMake(7, 12, 7, 12 + 10)];
    [_returnButton addTarget:self action:@selector(returnBack) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_returnButton];
    
    //支付状态图片
    CGFloat imageWidth = 75 * kScreenWidth/375.0;
    _stateImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
    _stateImageView.center = CGPointMake(self.centerX, 150 * kScreenWidth/375.0);
    _stateImageView.image = [UIImage imageNamed:@"pay_failed"];
    [self addSubview:_stateImageView];
    
    //支付状态label
    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stateImageView.frame) + 10, self.width, 20)];
    _stateLabel.font = [UIFont systemFontOfSize:15];
    _stateLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    _stateLabel.text = @"支付失败";
    [self addSubview:_stateLabel];
    
    //内容label
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width * 0.25, CGRectGetMaxY(_stateLabel.frame) + 50, self.width * 0.5, 30)];
    NSString *contentString = @"由于不知名的生物入侵地球，导致您的支付失败，请选择重新尝试";
    CGFloat contentHeight = [WXLabel getTextHeight:15 width:kScreenWidth * 0.5 text:contentString linespace:1.5];
    _contentLabel.height = contentHeight;
    _contentLabel.font = [UIFont systemFontOfSize:15];
    _contentLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.text = contentString;
    _contentLabel.numberOfLines = 0;
    [self addSubview:_contentLabel];
    
    
    //查看订单按钮
    _payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _payButton.frame = CGRectMake(40, self.height - 45 - 45, self.width - 80, 45);
    [_payButton setBackgroundColor:[UIColor colorWithHexString:@"f5cd13"]];
    _payButton.layer.masksToBounds = YES;
    _payButton.layer.cornerRadius = _payButton.height / 2.0;
    [_payButton setTitle:@"重新支付" forState:UIControlStateNormal];
    [_payButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _payButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_payButton addTarget:self action:@selector(payButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_payButton];
}

//返回
- (void)returnBack{
    if ([self.delegate respondsToSelector:@selector(activityOrderFailViewQuit)]) {
        [self.delegate activityOrderFailViewQuit];
    }
}

//重新支付
- (void)payButtonAction{
    if ([self.delegate respondsToSelector:@selector(activityOrderFailViewPayAgain)]) {
        [self.delegate activityOrderFailViewPayAgain];
    }
}

@end
