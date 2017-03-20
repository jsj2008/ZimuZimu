//
//  ExamSectionHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExamSectionHeaderCell.h"

@interface ExamSectionHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation ExamSectionHeaderCell

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
    
    _titleLabel.textColor = themeBlack;
    _lineView.backgroundColor = themeGray;
    [_askButton setTitleColor:themeBlack forState:UIControlStateNormal];
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _markImageView.image = [UIImage imageNamed:_imageString];;
    }
}
- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
    }
}


- (void)setButtonTitle:(NSString *)buttonTitle{
    if (_buttonTitle != buttonTitle) {
        _buttonTitle = buttonTitle;
        [_askButton setTitle:_buttonTitle forState:UIControlStateNormal];
    }
}
- (void)setButtonImageString:(NSString *)buttonImageString{
    if (_buttonImageString != buttonImageString) {
        _buttonImageString = buttonImageString;
        [_askButton setImage:[UIImage imageNamed:_buttonImageString] forState:UIControlStateNormal];
    }
}

@end
