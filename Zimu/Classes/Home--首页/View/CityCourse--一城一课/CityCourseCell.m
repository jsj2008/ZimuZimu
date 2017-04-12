//
//  CityCourseCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseCell.h"

@interface CityCourseCell ()

@property (weak, nonatomic) IBOutlet UIImageView *courseImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tagIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIView *maskView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

@end

@implementation CityCourseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    _addressLabel.text = @"杭州拉萨";
}

//- (void)layoutSubviews{
////    _tagIamgeView.width = _addressLabel.width + 30;
//    
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setLayoutFrame:(CityCourseCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        _courseImageView.frame = layoutFrame.courseImageViewFrame;
        
        _maskView.frame = layoutFrame.maskViewFrame;
        
        _titleLabel.frame = layoutFrame.titleLabelFrame;
        
        _timeLabel.frame = layoutFrame.timeLabelFrame;
        
        _detailAddressLabel.frame = layoutFrame.detailAddressLabelFrame;
        
        //标签地址
        NSString *tagAddress = @"杭州";
        _addressLabel.text = tagAddress;
        CGSize tagAddressSize = [tagAddress sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _addressLabel.frame = CGRectMake(kScreenWidth - 10 - tagAddressSize.width, 0, tagAddressSize.width, tagAddressSize.height);
        
        //标签
        CGFloat tagWidth = tagAddressSize.width + 30;
        _tagIamgeView.frame = CGRectMake(kScreenWidth - tagWidth, 10, tagWidth, _tagIamgeView.image.size.height);
        _tagIamgeView.image = [_tagIamgeView.image stretchableImageWithLeftCapWidth:_tagIamgeView.width topCapHeight:0];
        _addressLabel.centerY = _tagIamgeView.centerY;
        
    }
}

@end
