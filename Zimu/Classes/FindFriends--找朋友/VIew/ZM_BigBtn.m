//
//  ZM_BigBtn.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_BigBtn.h"


static NSString *selectBgColor = @"F5CE13";
static NSString *normalBgColor = @"f7f7f7";

static NSString *textNormalCol = @"eeeeee";
static NSString *textSelectCol = @"ffffff";

@interface ZM_BigBtn ()

@property (nonatomic, strong) UIImageView *bigImg;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *canvansView; //蒙版



@end

@implementation ZM_BigBtn

- (instancetype)initWithImgName:(NSString *)imgName titleString:(NSString *)titleString frame:(CGRect) rect{
    self = [super init];
    if (self) {
        [self addSubview:self.bigImg];
        [self addSubview:self.titleLabel];
        //蒙版必须在imgView后面加载
        [self addSubview:_canvansView];
        
        //添加单机手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

#pragma mark - 懒加载
- (UIImageView *)bigImg{
    if (!_bigImg) {
        _bigImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:_imgName]];
        _bigImg.frame = CGRectMake(self.frame.origin.x, self.y, self.width, self.height -50);
        
        _canvansView = [[UIView alloc] initWithFrame:_bigImg.frame];
        _canvansView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.65];
        _canvansView.hidden = YES;
    }
    return _bigImg;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.x, self.height - 35, self.width, 25)];
        _titleLabel.text = _nameString;
        _titleLabel.backgroundColor = [UIColor colorWithHexString:normalBgColor];
        _titleLabel.textColor = [UIColor colorWithHexString:textNormalCol];
        _titleLabel.layer.cornerRadius = 12.5;
    }
    return _titleLabel;
}

- (void)setIsSelected:(BOOL)isSelected{
    _isSelected = isSelected;
    if (_isSelected) {
        _titleLabel.textColor = [UIColor colorWithHexString:textSelectCol];
        _titleLabel.backgroundColor = [UIColor colorWithHexString:selectBgColor];
        
        _canvansView.hidden = YES;
    }else{
        _titleLabel.textColor = [UIColor colorWithHexString:textNormalCol];
        _titleLabel.backgroundColor = [UIColor colorWithHexString:normalBgColor];
        
        _canvansView.hidden = NO;
    }
}
#pragma mark - 单击手势
- (void)tap:(UITapGestureRecognizer *)tap{
    self.isSelected  = !_isSelected;
}

@end
