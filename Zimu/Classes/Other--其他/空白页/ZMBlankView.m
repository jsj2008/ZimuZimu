//
//  ZMBlankView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZMBlankView.h"
#import <Masonry.h>

@interface ZMBlankView ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIButton *reFreshBtn;

@property (nonatomic, assign) ZMBlankType type;
@property (nonatomic, assign) BOOL shouldDestory;

@property (nonatomic, copy, nullable) ZMBlankBtnDidClick btnClick;

@end

@implementation ZMBlankView

- (instancetype)initWithFrame:(CGRect)frame Type:(ZMBlankType)type afterClickDestory:(BOOL)shouldDestory btnClick:(ZMBlankBtnDidClick)btnClick{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
        self.backgroundColor = [UIColor colorWithHexString:@"f2f3f7"];
        _btnClick = btnClick;
        _shouldDestory = shouldDestory;
        self.type = type;
    }
    return self;
}
//设置界面，创建控件
- (void)makeUI{
    [self addSubview:self.imgView];
    [self addSubview:self.textLabel];
    [self addSubview:self.reFreshBtn];
}

- (void)layoutSubviews{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(0);
        make.top.mas_equalTo(self.mas_top).with.offset(120);
    }];
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(0);
        make.top.mas_equalTo(_imgView.mas_bottom).offset(20);
    }];
    [_reFreshBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).with.offset(0);
        make.left.mas_equalTo(self.mas_left).with.offset(50);
        make.right.mas_equalTo(self.mas_right).with.offset(-50);
        make.top.mas_equalTo(_textLabel.mas_bottom).with.offset(100);
        make.height.mas_equalTo(45);
    }];
    
}

- (void)btnClick:(UIButton *)btn{
    if (_btnClick) {
        _btnClick(self);
        if (_shouldDestory == YES) {
            [self destory];
        }
    }
}

- (void)destory{
    self.btnClick = nil;
    [self removeFromSuperview];
}
#pragma mark - getter
- (UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}
- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:13];
        _textLabel.textColor = [UIColor colorWithHexString:@"666666"];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 2;
    }
    return _textLabel;
}
- (UIButton *)reFreshBtn{
    if (!_reFreshBtn) {
        _reFreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reFreshBtn.layer.cornerRadius = 22.5;
        _reFreshBtn.layer.masksToBounds = YES;
        [_reFreshBtn setTitleColor:themeWhite forState:UIControlStateNormal];
        _reFreshBtn.backgroundColor = [UIColor colorWithHexString:@"F5CD13"];
        [_reFreshBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reFreshBtn;
}
#pragma mark - setter
- (void)setType:(ZMBlankType)type{
    _type = type;
    NSString *imgString = @"";
    NSString *textString = @"";
    NSString *btnTitle = @"";
    switch (_type) {
        case ZMBlankTypeDefault:
        {
            imgString = @"blank_nodata";
            textString = @"咦，没有数据\n去其他页面看看吧";
            btnTitle = @"重新加载";
        }
            break;
        case ZMBlankTypeNoData:
        {
            imgString = @"blank_nodata";
            textString = @"咦，没有数据\n去其他页面看看吧";
            btnTitle = @"重新加载";
        }
            break;
        case ZMBlankTypeNoNet:
        {
            imgString = @"blank_nonet";
            textString = @"咦，网络走丢了\n检查网络再试试";
            btnTitle = @"重新加载";
        }
            break;
        case ZMBlankTypeNoFriend:
        {
            imgString = @"blank_nofriend";
            textString = @"好朋友都在哪儿？\n赶紧去找找";
            btnTitle = @"添加好友";
        }
            break;
        default:
            break;
    }
    _imgView.image = [UIImage imageNamed:imgString];
    _textLabel.text = textString;
    [_reFreshBtn setTitle:btnTitle forState:UIControlStateNormal];
    
}
@end
