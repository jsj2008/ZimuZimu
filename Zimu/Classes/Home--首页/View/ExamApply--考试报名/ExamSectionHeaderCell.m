//
//  ExamSectionHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExamSectionHeaderCell.h"

@interface ExamSectionHeaderCell ()

@property (weak, nonatomic) IBOutlet UIView *markView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;


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
    
    _markView.backgroundColor = themeYellow;
    _titleLabel.textColor = themeBlack;
    _lineView.backgroundColor = themeGray;
    _moreLabel.text = @"查看全部";
    _moreLabel.textColor = themeYellow;
}


- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
    }
}


@end
