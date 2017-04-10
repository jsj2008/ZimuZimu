//
//  BookCourseCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BookCourseCell.h"
#import "BookCourseCollectionView.h"

@interface BookCourseCell ()

@property (weak, nonatomic) IBOutlet BookCourseCollectionView *bookCourseCollectionView;


@end

@implementation BookCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
