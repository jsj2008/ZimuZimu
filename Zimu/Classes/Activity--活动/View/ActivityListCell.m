//
//  ActivityListCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityListCell.h"

@interface ActivityListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end

@implementation ActivityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (kScreenWidth == 320) {
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _priceLabel.font = [UIFont boldSystemFontOfSize:15];
    }else{
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _priceLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
    }
}

- (void)setPriceString:(NSString *)priceString{
    if (_priceString != priceString) {
        _priceString = [NSString stringWithFormat:@"￥%@",priceString];
        _priceLabel.text = _priceString;
    }
}

- (void)setBgImageString:(NSString *)bgImageString{
    if (_bgImageString != bgImageString) {
        _bgImageString = bgImageString;
        _bgImageView.image = [UIImage imageNamed:bgImageString];
    }
}


@end
