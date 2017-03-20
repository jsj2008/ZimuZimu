//
//  FMCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMCollectionViewCell.h"

@interface FMCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *FMImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end
@implementation FMCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _FMImageView.clipsToBounds = YES;
    _FMImageView.layer.cornerRadius = 5;
    _FMImageView.layer.masksToBounds = YES;
    _titleLabel.textColor = themeBlack;
    //    UIImage *image = _FMImageView.image;
    //    image = [image imageAddCornerWithRadious:5 size:_FMImageView.size];
    //    _FMImageView.image = image;
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _FMImageView.image = [UIImage imageNamed:_imageString];
        
    }
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        
    }
}

@end
