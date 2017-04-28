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
    _titleLabel.text = @"暂时还没有专家回答，您可以一对一咨询\n更快速的解决您的问题";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
