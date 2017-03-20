//
//  QAPreviousQACell.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QAPreviousQACell.h"

@interface QAPreviousQACell ()

@property (weak, nonatomic) IBOutlet UIImageView *markImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation QAPreviousQACell

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
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        
    }
}

@end
