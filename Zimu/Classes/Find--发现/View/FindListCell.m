//
//  FindListCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FindListCell.h"

@interface FindListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *countLabel;

@property (nonatomic, copy) NSString *flagImageString;

@end

@implementation FindListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self draw];
}

- (void)draw{
    
    //背景图
    _bgImageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    //flag标签
    _flagImageView.image = [UIImage imageNamed:_flagImageString];
    _flagImageView.frame = CGRectMake(self.width - 10 - _flagImageView.image.size.width, 10, _flagImageView.image.size.width, _flagImageView.image.size.height);
    
    //标题
    CGFloat titleWidth = 100 * kScreenWidth / 375.0;
    _titleLabel.numberOfLines = 2;
    _titleLabel.frame = CGRectMake(self.width - titleWidth - 30, (self.height - 40)/2.0, titleWidth, 40);
    
    //查看数
    CGSize size = [_countString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    size.height = 20;
    size.width = size.width + 25;
    _countLabel.frame = CGRectMake(self.width - size.width - 10, self.height - 10 - size.height, size.width, size.height);
    
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        [self draw];
    }
}


- (void)setbgImageString:(NSString *)bgImageString{
    if (_bgImageString != bgImageString) {
        _bgImageString = bgImageString;
        _bgImageView.image = [UIImage imageNamed:bgImageString];
        [self draw];
    }
}

- (void)setCountString:(NSString *)countString{
    if (_countString != countString) {
        _countString = countString;
        [_countLabel setTitle:countString forState:UIControlStateNormal];
        [self draw];
    }
}

@end
