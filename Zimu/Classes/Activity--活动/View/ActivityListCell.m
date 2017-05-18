//
//  ActivityListCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityListCell.h"
#import <UIImageView+WebCache.h>

@interface ActivityListCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;


@end

@implementation ActivityListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    if (kScreenWidth == 320) {
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _priceLabel.font = [UIFont boldSystemFontOfSize:15];
    }else{
        _titleLabel.font = [UIFont boldSystemFontOfSize:25];
        _priceLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setActivityListModel:(ActivityListModel *)activityListModel{
    _titleLabel.text = activityListModel.categoryName;
    _priceLabel.text = [NSString stringWithFormat:@"￥%@",activityListModel.coursePrice];
    NSString *imgURLString = [imagePrefixURL stringByAppendingString:activityListModel.imgUrl];
    [_bgImageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:@"activity_list2"]];
}

@end
