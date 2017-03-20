//
//  OpenCourseVideoCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OpenCourseVideoCollectionViewCell.h"

@interface OpenCourseVideoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation OpenCourseVideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _videoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _videoImageView.clipsToBounds = YES;
    _videoImageView.layer.cornerRadius = 5;
    _videoImageView.layer.masksToBounds = YES;
    
    _titleLabel.textColor = [UIColor darkGrayColor];
    _freeLabel.textColor = [UIColor lightGrayColor];
    _countLabel.textColor = [UIColor lightGrayColor];
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _videoImageView.image = [UIImage imageNamed:_imageString];
    }
}

@end
