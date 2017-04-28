//
//  VideoCourseBigCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "VideoCourseBigCell.h"

@interface VideoCourseBigCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *videoIconView;
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@end

@implementation VideoCourseBigCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _courseImageView.image = [UIImage imageNamed:_imageString];
    }
}


@end
