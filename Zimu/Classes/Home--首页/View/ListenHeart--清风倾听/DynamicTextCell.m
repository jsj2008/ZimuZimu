//
//  DynamicTextCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "DynamicTextCell.h"

@interface DynamicTextCell ()

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation DynamicTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = [NSString stringWithFormat:@"  %@",_titleString];
        [self layoutIfNeeded];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //竖线
    _lineView.frame = CGRectMake(20, 0, 1, self.height);
    
    //小圈圈
    _circleView.size = CGSizeMake(10, 10);
    _circleView.center = _lineView.center;
    _circleView.layer.cornerRadius = 5;
    
    //标题
    
    CGSize titleSize = [_titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat titleWidth = titleSize.width + 20;
    if (titleWidth > kScreenWidth - CGRectGetMaxX(_circleView.frame) - 10 - 10) {   //10为label左右间距
        titleWidth = kScreenWidth - CGRectGetMaxX(_circleView.frame) - 10 - 10;
    }
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_circleView.frame) + 10, _circleView.centerY - 15, titleWidth, 30);
    _titleLabel.backgroundColor = themeGray;
    _titleLabel.layer.cornerRadius = 3;
}


@end
