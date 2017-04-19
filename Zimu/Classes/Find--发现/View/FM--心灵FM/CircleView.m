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
@property (nonatomic, assign) BOOL playing;
@property (nonatomic, strong) CAGradientLayer *gradientLayer;
@property (nonatomic, strong) CAShapeLayer *bgLayer;

@end

@implementation CircleView

- (void)drawCircle{
    CGFloat lineWidth = 9.0f;
    CGFloat radius = self.width/2.0 - lineWidth/2.0;
    CGFloat startAngle = -0.5f * M_PI;
    CGFloat endAngle = 1.5f * M_PI;
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.width/2.0, self.height/2.0) radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    
    //添加背景圆环
    if (_bgLayer) {
        [_bgLayer removeFromSuperlayer];
        _bgLayer = nil;
    }
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.frame = self.bounds;
    _bgLayer.lineWidth = lineWidth;
    _bgLayer.fillColor = nil;
    _bgLayer.strokeColor = [UIColor colorWithHexString:@"FFEAAA"].CGColor;
    _bgLayer.strokeEnd = 1.0f;
    _bgLayer.path = bezierPath.CGPath;
    [self.layer addSublayer:_bgLayer];
    
    //创建进度layer
    if (_progressLayer) {
        [_progressLayer removeFromSuperlayer];
        _progressLayer = nil;
    }
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
    if (_gradientLayer) {
        [_gradientLayer removeFromSuperlayer];
        _gradientLayer = nil;
    }
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = self.bounds;
    [_gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHexString:@"FF9700"] CGColor],(id)[[UIColor colorWithHexString:@"FFCB00"] CGColor], nil]];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(0, 1);
    [_gradientLayer setMask:_progressLayer];
    [self.layer addSublayer:_gradientLayer];
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
    self.progressLayer.strokeStart = 0;
    dispatch_async(dispatch_get_main_queue(), ^{
        if (progress == 0) {
            self.progressLayer.hidden = YES;
            self.progressLayer.strokeEnd = progress;
            
//            [self drawCircle];
            
        }else {
            self.progressLayer.hidden = NO;
            self.progressLayer.strokeEnd = progress;
        }
    });
    
}


@end
