//
//  VideoCourseCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "VideoCourseCollectionViewCell.h"

@interface VideoCourseCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation VideoCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _courseImageView.image = [UIImage imageNamed:_imageString];
        
    }
}

- (void)setTitleString:(NSString *)titleString{
    if (_titleString != titleString) {
        _titleString = titleString;
        _titleLabel.text = _titleString;
        
    }
}

@end
