//
//  OpenCourseVideoCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "OpenCourseVideoCell.h"
#import "VideoCourseCollectionView.h"

@interface OpenCourseVideoCell ()
@property (weak, nonatomic) IBOutlet VideoCourseCollectionView *videoCourseCollectionView;

@end
@implementation OpenCourseVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImageArray:(NSArray *)imageArray{
    if (_imageArray != imageArray) {
        _imageArray = imageArray;
        _videoCourseCollectionView.imageArray = _imageArray;
    }
}

@end
