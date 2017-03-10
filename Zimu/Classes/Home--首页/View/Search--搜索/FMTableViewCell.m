//
//  FMTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMTableViewCell.h"

@interface FMTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *FMImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;


@end

@implementation FMTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _FMImageView.image = [UIImage imageNamed:@"cycle_05.jpg"];
    _titleLabel.text = @"宝贝喜爱的睡前故事";
    _titleLabel.textColor = themeBlack;
    _playTimeLabel.text = @"播放：48.6万";
    _authorLabel.text = @"上传：李老师";
    _introLabel.text = @"关于孩子的故事，每天讲给你听";
    
}


@end
