//
//  HomeTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/2/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *ZMImageView;
@property (weak, nonatomic) IBOutlet UIView *bottomBGView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _ZMImageView.image = [UIImage imageNamed:_imageString];
    _bottomBGView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _titleLabel.text = @"你的孩子为什么不愿意和你交心？";
    _introLabel.text = @"你的孩子之所以不怨你和你交心，这其实是你的原因";
    _countLabel.text = @"9999人阅读";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _ZMImageView.image = [UIImage imageNamed:_imageString];
    }
}

@end
