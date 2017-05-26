//
//  ActivityApplyInfoView.m
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityApplyInfoView.h"

@interface ActivityApplyInfoView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *addressLabel;

@end

@implementation ActivityApplyInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = themeWhite;
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    
    CALayer *botLine = [[CALayer alloc]init];
    botLine.frame = CGRectMake(0, self.height - 1, self.width, 1);
    botLine.backgroundColor = themeGray.CGColor;
    [self.layer addSublayer:botLine];
    
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
    _headerView.backgroundColor = themeWhite;
    CALayer *line = [[CALayer alloc]init];
    line.frame = CGRectMake(0, _headerView.height - 1, _headerView.width, 1);
    line.backgroundColor = themeGray.CGColor;
    [_headerView.layer addSublayer:line];
    [self addSubview:_headerView];
    
    //标题
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.frame = CGRectMake(10, 15, 200, 20);
    _titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    _titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [_headerView addSubview:_titleLabel];
    
    //取消
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelButton.frame = CGRectMake(_headerView.width - _headerView.height - 10, 0, _headerView.height, _headerView.height);
    [_cancelButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    CGSize cancelSize = _cancelButton.currentImage.size;
    [_cancelButton setImageEdgeInsets:UIEdgeInsetsMake((_cancelButton.height - cancelSize.height)/2.0, _cancelButton.width - cancelSize.width, (_cancelButton.height - cancelSize.height)/2.0, 0)];
    [_cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_cancelButton];
    
    //时间
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.frame = CGRectMake(30, CGRectGetMaxY(_headerView.frame) + 15, self.width - 60, 20);
    _timeLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    _timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_timeLabel];
    
    //地点
    _addressLabel = [[UILabel alloc] init];
    _addressLabel.frame = CGRectMake(CGRectGetMinX(_timeLabel.frame), CGRectGetMaxY(_timeLabel.frame) + 10, self.width - 60, 20);
//    _addressLabel.text = @"地点：杭州市滨江区";
    _addressLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    _addressLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self addSubview:_addressLabel];
    
}

- (void)cancel{
    NSLog(@"取消");
}

- (void)setPaymentInfoModel:(PaymentInfoModel *)paymentInfoModel{
    //标题
    _titleLabel.text = [NSString stringWithFormat:@"%@报名信息",paymentInfoModel.title];
    
    //时间
//    NSString *timeString = [];
    _timeLabel.text = [NSString stringWithFormat:@"时间：%@",paymentInfoModel.time];
    
    //地点
    _addressLabel.text = [NSString stringWithFormat:@"地点：%@",paymentInfoModel.address];
}


@end
