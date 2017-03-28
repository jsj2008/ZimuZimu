//
//  DailyStudyCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "DailyStudyCell.h"

@interface DailyStudyCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *readCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation DailyStudyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
