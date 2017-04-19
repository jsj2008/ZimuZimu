//
//  CourseTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseTableViewCell.h"

@interface CourseTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *maskImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;


@end

@implementation CourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _courseImageView.image = [UIImage imageNamed:@"cycle_02.jpg"];
    _titleLabel.text = @"宝贝喜爱的儿童故事";
    _titleLabel.textColor = themeBlack;
    _playTimeLabel.text = @"播放：21.5万";
    _authorLabel.text = @"上传：吴老师";
    _introLabel.text = @"关于孩子的故事，每天讲给你听";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
