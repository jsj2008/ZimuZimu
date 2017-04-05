//
//  CircleView.m
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CircleView.h"

@interface CircleView (){
    CGFloat _strokeStart;
    CGFloat _strokeNow;
}

@property (nonatomic, strong) UIImageView *bgImageView;     //背景图片
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, assign) BOOL playing;

@end

@implementation CircleView

- (void)drawCircle{
    CGFloat lineWidth = 9.0f;
    CGFloat radius = self.width/2.0 - lineWidth/2.0;
    CGFloat startAngle = -0.5f * M_PI;
    CGFloat endAngle = 1.5f * M_PI;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2.0, self.height/2.0) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    //添加背景圆环
    CAShapeLayer *bgLayer = [CAShapeLayer layer];
    bgLayer.frame = self.bounds;
    bgLayer.lineWidth = lineWidth;
    bgLayer.fillColor = nil;
    bgLayer.strokeColor = [UIColor colorWithHexString:@"FFEAAA"].CGColor;
    bgLayer.strokeEnd = 1.0f;
    bgLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:bgLayer];
    
    //创建进度layer
    _progressLayer = [CAShapeLayer layer];
    _progressLayer.frame = self.bounds;
    _progressLayer.fillColor =  [[UIColor clearColor] CGColor];
    //指定path的渲染颜色
    _progressLayer.strokeColor  = [[UIColor blackColor] CGColor];
    _progressLayer.lineCap = kCALineCapRound;
    _progressLayer.lineWidth = lineWidth;
    _progressLayer.path = [bezierPath CGPath];
    _progressLayer.strokeEnd = 0;
    
    //渐变色层
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHexString:@"FF9700"] CGColor],(id)[[UIColor colorWithHexString:@"FFCB00"] CGColor], nil]];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    [gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:gradientLayer];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = themeWhite;
        _playing = NO;
        _strokeStart = 0;
        _strokeNow = 0;
        [self addSubview:self.bgImageView];
        [self drawCircle];
        
    }
    return self;
}


- (UIImageView *)bgImageView{
    if (!_bgImageView) {
        CGFloat lineWidth = 9.0f;
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(lineWidth, lineWidth, self.width - lineWidth * 2, self.height - lineWidth * 2)];
        _bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        _bgImageView.image = [UIImage imageNamed:@"course_hot"];
        _bgImageView.layer.cornerRadius = _bgImageView.width/2.0;
        _bgImageView.layer.masksToBounds = YES;
        
        //盖一层蒙版
        CALayer *maskLayer = [[CALayer alloc]init];
        maskLayer.frame = _bgImageView.bounds;
        maskLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3].CGColor;
        [_bgImageView.layer addSublayer:maskLayer];
        
    }
    return _bgImageView;
}

- (void)setProgress:(CGFloat)progress{
    if (progress == 0) {
        self.progressLayer.hidden = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressLayer.strokeEnd = 0;
        });
    }else {
        self.progressLayer.hidden = NO;
        self.progressLayer.strokeEnd = progress;
    }
}


@end
