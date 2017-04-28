//
//  HomeCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface HomeCollectionViewCell ()


@end

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)layoutSubviews{
    [super layoutSubviews];

    [self draw];
}

- (void)draw{
    //标题
    UIFont *font = [UIFont systemFontOfSize:15];
    if (kScreenWidth == 320) font = [UIFont boldSystemFontOfSize:13];
    CGSize titleSize = [_titleString sizeWithAttributes:@{NSFontAttributeName:font}];
    _titleLabel.font = font;
    _titleImageView.frame = CGRectMake(10, 12, titleSize.height, titleSize.height);
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_titleImageView.frame) + 5, CGRectGetMinY(_titleImageView.frame), self.width - CGRectGetMaxX(_titleImageView.frame) - 5 - 10, titleSize.height);
    
    //背景
    _bgImageView.frame = CGRectMake(0, 0, self.width, self.height);
    
    //覆盖图
    CGFloat width = _coverImageView.image.size.width;
    CGFloat height = _coverImageView.image.size.height;
    if (kScreenWidth == 320) {
        width = _coverImageView.image.size.width * 0.8;
        height = _coverImageView.image.size.height * 0.8;
    }
    _coverImageView.frame = CGRectMake(self.width - width - 1.5, self.height - height - 2.5, width, height);
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        [self draw];
    }
}

- (void)setTitleImageString:(NSString *)titleImageString{
    if (_titleImageString != titleImageString) {
        _titleImageString = titleImageString;
        _titleImageView.image = [UIImage imageNamed:_titleImageString];
    }
}

- (void)setCoverImageString:(NSString *)coverImageString{
    if (_coverImageString != coverImageString) {
        _coverImageString = coverImageString;
        _coverImageView.image = [UIImage imageNamed:_coverImageString];
        [self draw];
    }
}

- (void)setBgimageString:(NSString *)bgimageString{
    if (_bgimageString != bgimageString) {
        _bgimageString = bgimageString;
        _bgImageView.image = [UIImage imageNamed:_bgimageString];
    }
}

- (void)setDataDic:(NSDictionary *)dataDic{
    if (_dataDic != dataDic) {
        _dataDic = dataDic;
        NSString *bgImageString = dataDic[@"bgImageString"];
        NSString *bgPlaceHolderImage = dataDic[@"bgPlaceHolderImage"];
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imagePrefixURL, bgImageString]] placeholderImage:[UIImage imageNamed:bgPlaceHolderImage]];
        
        NSString *coverImageString = dataDic[@"coverImageString"];
        NSString *coverPlaceHolderImage = dataDic[@"coverPlaceHolderImage"];
        [_coverImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",imagePrefixURL, coverImageString]] placeholderImage:[UIImage imageNamed:coverPlaceHolderImage]];
    }
}
@end
