//
//  ZMSlider.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZMSlider.h"

@interface ZMSlider ()

@property (nonatomic,strong) UIView *leftView;          //进度view
@property (nonatomic,strong) UILabel *currentTextLabel;     //当前进度数值
@property (nonatomic,strong) UILabel *maxTextLabel;         //总值
@property (nonatomic,strong) UIView *circleView;
@property (nonatomic) CGFloat zmMaxValue;

@end

@implementation ZMSlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

/*当前进度*/
- (void)setCurrentSliderValue:(CGFloat)currentSliderValue{
    _currentSliderValue = currentSliderValue;
    
    _leftView.frame = CGRectMake(0, 0, currentSliderValue / (_zmMaxValue/self.frame.size.width), self.frame.size.height);
    //圆圈位置
    CGFloat width = self.height + 10;
    _circleView .frame = CGRectMake(0, 0, width, width);
    _circleView.center = CGPointMake(CGRectGetMaxX(self.leftView.frame) - width/2.0, self.leftView.centerY);
    //进度数值位置
    _currentTextLabel.center = CGPointMake(_circleView.centerX, CGRectGetMinY(_circleView.frame) - 10);
    CGFloat ratio = _currentSliderValue/_zmMaxValue * 100;
    _currentTextLabel.text = [NSString stringWithFormat:@"%.0lf%%",ratio];
    _maxTextLabel.center = CGPointMake(self.width, _currentTextLabel.centerY);
}

- (void)setMaxValue:(CGFloat)maxValue{
    _zmMaxValue = maxValue;
    _maxTextLabel.text = [NSString stringWithFormat:@"%.0lf",_zmMaxValue];
}

- (void)setCurrentValueColor:(UIColor *)currentValueColor{
    self.leftView.backgroundColor = currentValueColor;
}


- (void)setCircleViewColor:(UIColor *)circleViewColor{
    _circleView.backgroundColor = circleViewColor;
}


- (void)setup{
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.backgroundColor = [UIColor colorWithHexString:@"D1D1D1"];
    
    /** 进度视图*/
    _leftView = [[UIView alloc]init];
    _leftView.layer.cornerRadius = self.frame.size.height / 2;
    [self addSubview:_leftView];
    
    /** 当前数值显示label*/
    _currentTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    _currentTextLabel.textAlignment = NSTextAlignmentCenter;
    _currentTextLabel.textColor = [UIColor colorWithHexString:@"D1D1D1"];
    _currentTextLabel.font = [UIFont boldSystemFontOfSize:13.0];
    [self addSubview:_currentTextLabel];
    
    /** 总数值显示label*/
    _maxTextLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 20, -20, 40, 20)];
    _maxTextLabel.textAlignment = NSTextAlignmentCenter;
    _maxTextLabel.textColor = [UIColor colorWithHexString:@"D1D1D1"];
    _maxTextLabel.font = [UIFont boldSystemFontOfSize:13.0];
    [self addSubview:_maxTextLabel];
    
    /** 圆形触摸块*/
    _circleView  = [[UIView alloc]init];
    _circleView.layer.cornerRadius = (self.frame.size.height + 10) /2;
    _circleView.layer.masksToBounds = YES;
    [self addSubview:_circleView];
    
    /** 默认最大值*/
    _zmMaxValue = 255.0;
    _maxTextLabel.text = [NSString stringWithFormat:@"%.0lf",_zmMaxValue];
    
}





@end
