//
//  CallPhoneView.m
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CallPhoneView.h"
#import "UIImage+ZMExtension.h"

@interface CallPhoneView ()

@property (nonatomic, strong) UILabel *titlelabel;
@property (nonatomic, strong) UIButton *callButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation CallPhoneView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = themeGray;
        
        _phoneString = @"18268802188";      //默认电话

        [self setupTitlelabel];
        [self setupCallButton];
        [self setupCancelButton];
    
    }
    return self;
}

- (void)setupTitlelabel{
    _titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
    _titlelabel.backgroundColor = themeWhite;
    _titlelabel.text = @"联系电话";
    _titlelabel.font = [UIFont systemFontOfSize:14];
    _titlelabel.textAlignment = NSTextAlignmentCenter;
    _titlelabel.textColor = [UIColor colorWithHexString:@"333333"];
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, _titlelabel.height - 1, _titlelabel.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_titlelabel.layer addSublayer:line];
    [self addSubview:_titlelabel];
}

- (void)setupCallButton{
    _callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _callButton.frame = CGRectMake(0, CGRectGetMaxY(_titlelabel.frame), self.width, 50);
    [_callButton setBackgroundImage:[UIImage imageWithColor:themeWhite size:_callButton.size] forState:UIControlStateNormal];
    [_callButton setBackgroundImage:[UIImage imageWithColor:themeGray size:_callButton.size] forState:UIControlStateHighlighted];
    [_callButton setTitle:[NSString stringWithFormat:@"客服电话:%@",_phoneString] forState:UIControlStateNormal];
    [_callButton setTitleColor:themeBlack forState:UIControlStateNormal];
    _callButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_callButton addTarget:self action:@selector(callPhone) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_callButton];
}

- (void)setPhoneString:(NSString *)phoneString{
    if (_phoneString != phoneString) {
        _phoneString = phoneString;
        [_callButton setTitle:[NSString stringWithFormat:@"客服电话:%@",_phoneString] forState:UIControlStateNormal];
    }
}

//拨打电话
- (void)callPhone{
    NSString *phoneNumber = [NSString stringWithFormat:@"tel://%@",_phoneString];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
    
    if ([self.delegate respondsToSelector:@selector(callPhoneViewDidClickClose)]) {
        [self.delegate callPhoneViewDidClickClose];
    }
}

- (void)setupCancelButton{
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(0, CGRectGetMaxY(_callButton.frame) + 3, self.width, 50);
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:themeBlack forState:UIControlStateNormal];
    [_cancelButton setBackgroundColor:themeWhite];
    _cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelButton];
}

//取消
- (void)cancel{
    if ([self.delegate respondsToSelector:@selector(callPhoneViewDidClickClose)]) {
        [self.delegate callPhoneViewDidClickClose];
    }
}



@end
