//
//  ActivityOrderSuccessView.m
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityOrderSuccessView.h"
#import "WXLabel.h"

@interface ActivityOrderSuccessView ()

@property (nonatomic, strong) UIButton *returnButton;       //返回按钮
@property (nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic, strong) UILabel *stateLabel;
@property (nonatomic, strong) UIView  *contentView;

@property (nonatomic, strong) UILabel *titleLabel;          //活动内容
@property (nonatomic, strong) UILabel *titleMarkLabel;

@property (nonatomic, strong) UILabel *timeLabel;           //活动时间
@property (nonatomic, strong) UILabel *timeMarkLabel;

@property (nonatomic, strong) UILabel *addressLabel;        //活动地址
@property (nonatomic, strong) UILabel *addressMarkLabel;

@property (nonatomic, strong) UIButton *checkOrderButton;   //查看订单


@end

@implementation ActivityOrderSuccessView

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
    _stateImageView.image = [UIImage imageNamed:@"pay_success"];
    [self addSubview:_stateImageView];
    
    //支付状态label
    _stateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_stateImageView.frame) + 10, self.width, 20)];
    _stateLabel.font = [UIFont systemFontOfSize:15];
    _stateLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _stateLabel.textAlignment = NSTextAlignmentCenter;
    _stateLabel.text = @"报名成功";
    [self addSubview:_stateLabel];
    
    //报名信息
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    _contentView.layer.cornerRadius = 5;
    [self addSubview:_contentView];
    [self caculateContentHeight];
    
    //查看订单按钮
    _checkOrderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkOrderButton.frame = CGRectMake(40, self.height - 45 - 45, self.width - 80, 45);
    [_checkOrderButton setBackgroundColor:[UIColor colorWithHexString:@"f5cd13"]];
    _checkOrderButton.layer.masksToBounds = YES;
    _checkOrderButton.layer.cornerRadius = _checkOrderButton.height / 2.0;
    [_checkOrderButton setTitle:@"查看订单" forState:UIControlStateNormal];
    [_checkOrderButton setTitleColor:themeWhite forState:UIControlStateNormal];
    _checkOrderButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_checkOrderButton addTarget:self action:@selector(checkOrder) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_checkOrderButton];
}

//计算contentView的高度
- (void)caculateContentHeight{
    CGFloat contentWidth = self.width - 30*kScreenWidth/375.0 * 2;
    _contentView.frame = CGRectMake(30*kScreenWidth/375.0, CGRectGetMaxY(_stateLabel.frame) + 50, contentWidth, 200);

    //活动内容
    if (_titleMarkLabel) {
        [_titleMarkLabel removeFromSuperview];
        _titleMarkLabel = nil;
    }
    NSString *markString = @"活动内容：";
    CGSize markSize = [markString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _titleMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, markSize.width, markSize.height)];
    _titleMarkLabel.font = [UIFont systemFontOfSize:14];
    _titleMarkLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _titleMarkLabel.text = markString;
    [_contentView addSubview:_titleMarkLabel];
    NSString *titleString = _offlineCourseModel.courseName;//@"亲子共学团";
    CGFloat titleHeight = [WXLabel getTextHeight:14 width:contentWidth - markSize.width text:titleString linespace:1.5];
    if (_titleLabel) {
        [_titleLabel removeFromSuperview];
        _titleLabel = nil;
    }
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_titleMarkLabel.frame), CGRectGetMinY(_titleMarkLabel.frame), contentWidth - 10 - CGRectGetMaxX(_titleMarkLabel.frame), titleHeight)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _titleLabel.text = titleString;
    _timeLabel.numberOfLines = 0;
    [_contentView addSubview:_titleLabel];
    
    //活动时间
    if (_timeMarkLabel) {
        [_timeMarkLabel removeFromSuperview];
        _timeMarkLabel = nil;
    }
    markString = @"活动时间：";
    _timeMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_titleLabel.frame) + 15, markSize.width, markSize.height)];
    _timeMarkLabel.font = [UIFont systemFontOfSize:14];
    _timeMarkLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _timeMarkLabel.text = markString;
    [_contentView addSubview:_timeMarkLabel];
    NSString *timeString = @"2017年06月03日 13:00";
    CGFloat timeHeight = [WXLabel getTextHeight:14 width:contentWidth - markSize.width text:timeString linespace:1.5];
    if (_timeLabel) {
        [_timeLabel removeFromSuperview];
        _timeLabel = nil;
    }
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_timeMarkLabel.frame), CGRectGetMinY(_timeMarkLabel.frame), contentWidth - 10 - CGRectGetMaxX(_timeMarkLabel.frame), timeHeight)];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _timeLabel.text = timeString;
    _timeLabel.numberOfLines = 0;
    [_contentView addSubview:_timeLabel];
    
    //活动地点
    if (_addressMarkLabel) {
        [_addressMarkLabel removeFromSuperview];
        _addressMarkLabel = nil;
    }
    markString = @"活动地点：";
    _addressMarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_timeLabel.frame) + 15, markSize.width, markSize.height)];
    _addressMarkLabel.font = [UIFont systemFontOfSize:14];
    _addressMarkLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _addressMarkLabel.text = markString;
    [_contentView addSubview:_addressMarkLabel];
    NSString *addressString = [NSString stringWithFormat:@"%@%@",_offlineCourseModel.provinceName, _offlineCourseModel.address];//@"浙江省杭州市滨江区江陵路创意大厦1204室";
    CGFloat addressHeight = [WXLabel getTextHeight:14 width:contentWidth - markSize.width text:addressString linespace:1.5];
    if (_addressLabel) {
        [_addressLabel removeFromSuperview];
        _addressLabel = nil;
    }
    _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_addressMarkLabel.frame), CGRectGetMinY(_addressMarkLabel.frame), contentWidth - 10 - CGRectGetMaxX(_addressMarkLabel.frame), addressHeight)];
    _addressLabel.font = [UIFont systemFontOfSize:14];
    _addressLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _addressLabel.text = addressString;
    _addressLabel.numberOfLines = 0;
    [_contentView addSubview:_addressLabel];
    
    _contentView.height = CGRectGetMaxY(_addressLabel.frame) + 20;
}

//返回
- (void)returnBack{
    if ([self.delegate respondsToSelector:@selector(activityOrderSuccessViewQuit)]) {
        [self.delegate activityOrderSuccessViewQuit];
    }
}

//查看订单
- (void)checkOrder{
    if ([self.delegate respondsToSelector:@selector(activityOrderSuccessViewCheckOrder)]) {
        [self.delegate activityOrderSuccessViewCheckOrder];
    }
}

- (void)setOfflineCourseModel:(OfflineCourseModel *)offlineCourseModel{
    _offlineCourseModel = offlineCourseModel;
    [self caculateContentHeight];
    
}


@end

