//
//  BlankPageView.m
//  Demo
//
//  Created by Redpower on 2017/2/21.
//  Copyright © 2017年 Redpower. All rights reserved.
//

#import "BlankPageView.h"
#import "Masonry.h"

@implementation BlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)configWithType:(XMBlankPageType)XMBlankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError relodButtonBlock:(void (^)(id))block{
    //先判断是否有数据
    if (hasData) {
        //1.有数据
        [self removeFromSuperview];
        return;
    }
    
    //2.没数据
    //创建bgimageView
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_bgImageView];
        
    }
    //创建tipLabel
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.textColor = [UIColor lightGrayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.numberOfLines = 0;
        [self addSubview:_tipLabel];
    }
    //布局
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_centerY);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_bgImageView.mas_bottom);
        make.left.right.centerX.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    
    _reloadButtonBlock = nil;
    
    //判断是否有错误异常/加载失败
    if (hasError) {
        //有异常/加载失败
        //创建重新加载按钮reloadButton
        if (!_reloadButton) {
            _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_reloadButton setImage:[UIImage imageNamed:@"blankpage_button_reload"] forState:UIControlStateNormal];
            _reloadButton.adjustsImageWhenHighlighted = YES;
//            [_reloadButton setBackgroundColor:[UIColor greenColor]];
            [_reloadButton addTarget:self action:@selector(reloadButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_reloadButton];
            
            //布局
            [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_tipLabel.mas_bottom);
                make.centerX.mas_equalTo(self);
                make.size.mas_equalTo(CGSizeMake(160, 60));
                
            }];
            
        }
        _reloadButton.hidden = NO;
        _reloadButtonBlock = block;
        _bgImageView.image = [UIImage imageNamed:@"blankpage_image_loadFail"];
        _tipLabel.text = @"有异常的呀";
        
    }else{
        //无异常，只是没有数据
        if (_reloadButton) {
            _reloadButton.hidden = YES;
        }
        
        NSString *imageStr = @"";
        NSString *tipString = @"";
        
        switch (XMBlankPageType) {
            case XMBlankPageTypeNoData:
                imageStr = @"blankpage_image_Sleep";
                tipString = @"没数据啊兄弟！\n还不快去加点！！！";
                break;
                
            default:
                imageStr = @"blankpage_image_loadFail";
                tipString = @"有问题啊兄弟！\n快来看看吧！！！";
                
                break;
        }
        _bgImageView.image = [UIImage imageNamed:imageStr];
        _tipLabel.text = tipString;
        
    }
    
}

- (void)reloadButtonAction:(UIButton *)sender{
//    self.hidden = YES;
//    [self removeFromSuperview];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)0.2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
    
}


@end
