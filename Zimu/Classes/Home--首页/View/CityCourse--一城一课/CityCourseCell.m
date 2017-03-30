//
//  CityCourseCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseCell.h"

@interface CityCourseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tagIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *joinCountButton;

@end

@implementation CityCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _addressLabel.text = @"筹备中";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
