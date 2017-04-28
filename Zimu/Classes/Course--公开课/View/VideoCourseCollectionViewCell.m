//
//  VideoCourseCollectionViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "VideoCourseCollectionViewCell.h"
#import "UIImage+ZMExtension.h"
#import "UIImageView+WebCache.h"
#import "AlignmentLabel.h"

@interface VideoCourseCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet AlignmentLabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *lengthLabel;
@property (weak, nonatomic) IBOutlet UIButton *playCountLabel;



@end

@implementation VideoCourseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _titleLabel.textColor = themeBlack;
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _courseImageView.image = [UIImage imageNamed:_imageString];
    }
}


//免费课程
- (void)setHomeFreeCourseModel:(HomeFreeCourseItems *)homeFreeCourseModel{
    if (_homeFreeCourseModel != homeFreeCourseModel) {
        _homeFreeCourseModel = homeFreeCourseModel;
        _titleLabel.text = _homeFreeCourseModel.courseName;
        NSURL *url = [NSURL URLWithString:_homeFreeCourseModel.courseImg];
        [_courseImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_course1"]];
    }
}

//付费课程
- (void)setHomeNotFreeCourseModel:(HomeNotFreeCourseItems *)homeNotFreeCourseModel{
    if (_homeNotFreeCourseModel != homeNotFreeCourseModel) {
        _homeNotFreeCourseModel = homeNotFreeCourseModel;
        _titleLabel.text = homeNotFreeCourseModel.courseName;
        NSURL *url = [NSURL URLWithString:_homeFreeCourseModel.courseImg];
        [_courseImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"home_course2"]];
    }
}

@end
