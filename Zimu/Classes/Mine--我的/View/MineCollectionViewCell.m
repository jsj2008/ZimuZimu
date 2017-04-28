//
//  MineCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MineCollectionViewCell.h"

@interface MineCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation MineCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _bgImageView.image = [UIImage imageNamed:@"mine_beijing"];
}

- (void)setMarkImageString:(NSString *)markImageString{
    if (_markImageString != markImageString) {
        _markImageString = markImageString;
        
        _markImageView.image = [UIImage imageNamed:markImageString];
    }
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
    }
}

- (void)setColorString:(NSString *)colorString{
    if (_colorString != colorString) {
        _colorString = colorString;
        _titleLabel.textColor = [UIColor colorWithHexString:colorString];
    }
}


@end
