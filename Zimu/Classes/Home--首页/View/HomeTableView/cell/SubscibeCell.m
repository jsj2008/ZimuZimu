//
//  SubscibeCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscibeCell.h"
#import "UIImage+ZMExtension.h"


//static const NSInteger KCellHeight = 120;
static const NSInteger largeFont = 16;
static const NSInteger midFont = 14;
static const NSInteger midFont2 = 13;
static const NSInteger smallFont = 10;
@interface SubscibeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *refreshTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation SubscibeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //头像
    _headImageView.frame = CGRectMake(10, 10, 75, 100);
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5;
    _headImageView.layer.masksToBounds = YES;
    
    //价格
    CGFloat price = _homeExpretItem.expert.expertPrice.price;
    NSString *priceString = [NSString stringWithFormat:@"￥%.1lf/年",price];
    _priceLabel.text = priceString;
    _priceLabel.textColor = themeYellow;
    CGSize priceSize = [priceString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:midFont]}];
    _priceLabel.frame = CGRectMake(self.width - priceSize.width - 10, CGRectGetMinY(_headImageView.frame), priceSize.width, 20);
    
    //标题
    NSString *titleString = [NSString stringWithFormat:@"%@",_homeExpretItem.userName];
    _titleLabel.text = titleString;
    CGFloat titleWidth = CGRectGetMinX(_priceLabel.frame) - CGRectGetMaxX(_headImageView.frame) - 15 - 10;
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largeFont]}];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame) + 15, CGRectGetMinY(_headImageView.frame), titleWidth, titleSize.height);
    
    //简介
    NSString *introString = _homeExpretItem.expert.profile;
    _introLabel.text = introString;
    CGSize introSize = [introString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:midFont]}];
    _introLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 10, titleWidth, introSize.height);
    
    //最新内容
    NSString *contentString = [NSString stringWithFormat:@"%@ | %@",_homeExpretItem.latestSubscription.type, _homeExpretItem.latestSubscription.name];
    _contentLabel.text = contentString;
    CGFloat contentWidth = self.width - CGRectGetMaxX(_headImageView.frame) - 15 - 10 - 10;
    CGSize contentSize = [contentString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:midFont2]}];
    _contentLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_headImageView.frame) - contentSize.height, contentWidth, contentSize.height);
    
    //更新时间
    NSString *timeString = @"5小时前更新";
    CGSize timeSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:smallFont]}];
    _refreshTimeLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMinY(_contentLabel.frame) - 10 - (timeSize.height + 10), timeSize.width + 10, timeSize.height + 10);
    _refreshTimeLabel.layer.cornerRadius = 5;
    _refreshTimeLabel.layer.borderWidth = 0.5f;
    _refreshTimeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _headImageView.image = [UIImage imageNamed:_imageString];;
    }
}

- (void)setHomeExpretItem:(HomeExpertItems *)homeExpretItem{
    if (_homeExpretItem != homeExpretItem) {
        _homeExpretItem = homeExpretItem;
        
        [self layoutIfNeeded];
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
