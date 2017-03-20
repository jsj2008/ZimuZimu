//
//  ExamFreeVideoCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExamFreeVideoCollectionViewCell.h"

@interface ExamFreeVideoCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end
@implementation ExamFreeVideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _videoImageView.clipsToBounds = YES;
    _videoImageView.layer.cornerRadius = 5;
    _videoImageView.layer.masksToBounds = YES;
    _titleLabel.textColor = themeBlack;
    //    UIImage *image = _FMImageView.image;
    //    image = [image imageAddCornerWithRadious:5 size:_FMImageView.size];
    //    _FMImageView.image = image;
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _videoImageView.image = [UIImage imageNamed:_imageString];
        
    }
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        
    }
}

@end
