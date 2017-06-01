//
//  NoAnswerCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NoAnswerCell.h"

@interface NoAnswerCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation NoAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _titleLabel.text = @"暂时还没有专家回答";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPlaceholderText:(NSString *)placeholderText{
    if (_placeholderText != placeholderText) {
        _placeholderText = placeholderText;
        _titleLabel.text = placeholderText;
    }
}

@end
