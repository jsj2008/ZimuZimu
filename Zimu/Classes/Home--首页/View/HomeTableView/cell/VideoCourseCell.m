//
//  VideoCourseCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "VideoCourseCell.h"
#import "VideoCourseCollectionView.h"

@interface VideoCourseCell ()

@property (weak, nonatomic) IBOutlet VideoCourseCollectionView *videoCourseCollectionView;


@end

@implementation VideoCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setImageArray:(NSArray *)imageArray{
    if (_imageArray != imageArray) {
        _imageArray = imageArray;
        _videoCourseCollectionView.imageArray = _imageArray;
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
