//
//  SquareButtonView.m
//  Zimu
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SquareButtonView.h"
#import "Masonry.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SquareButtonView ()

@property (nonatomic, strong) UIButton *consultButton;      //在线咨询按钮
@property (nonatomic, strong) UIButton *appointButton;      //预约专家

@end

@implementation SquareButtonView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.consultButton];
        [self addSubview:self.appointButton];
        
        //布局
        [_consultButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(5);
            make.top.equalTo(self.mas_top).with.offset(5);
            make.bottom.equalTo(self.mas_bottom).with.offset(-5);
            make.width.equalTo(self.mas_width).multipliedBy(0.5).with.offset(-7.5);
        }];
        
        [_appointButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_consultButton.mas_right).with.offset(5);
            make.top.equalTo(_consultButton.mas_top);
            make.bottom.equalTo(_consultButton.mas_bottom);
            make.right.equalTo(self.mas_right).with.offset(-5);
        }];
    }
    return self;
}

/**
 *  在线咨询
 */
- (UIButton *)consultButton{
    if (!_consultButton) {
        _consultButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_consultButton setImage:[UIImage imageNamed:@"cycle_01.jpg"] forState:UIControlStateNormal];
        [[_consultButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.delegate consult];
        }];
    }
    return _consultButton;
}

/**
 *  预约专家
 */
- (UIButton *)appointButton{
    if (!_appointButton) {
        _appointButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_appointButton setImage:[UIImage imageNamed:@"cycle_02.jpg"] forState:UIControlStateNormal];
        [[_appointButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            [self.delegate appoint];
        }];
    }
    return _appointButton;
}


@end
