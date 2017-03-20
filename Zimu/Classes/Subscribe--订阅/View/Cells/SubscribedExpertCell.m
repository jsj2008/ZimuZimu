//
//  SubscribedExpertCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribedExpertCell.h"

static const NSInteger largeFont = 16;
static const NSInteger midFont = 14;
static const NSInteger smallFont = 10;
@interface SubscribedExpertCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UILabel *refreshTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation SubscribedExpertCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //头像
    _headImageView.frame = CGRectMake(10, 10, 75, 100);
    _headImageView.clipsToBounds = YES;
    _headImageView.layer.cornerRadius = 5;
    _headImageView.layer.masksToBounds = YES;
    
    //标题
    CGFloat titleWidth = self.width - CGRectGetMaxX(_headImageView.frame) - 15 - 10;
    NSString *titleString = @"吴老师  原生家庭关系论";
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largeFont]}];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_headImageView.frame) + 15, CGRectGetMinY(_headImageView.frame), titleWidth, titleSize.height);
    
    //简介
    NSString *introString = @"带你走进原生家庭孩子成长之路";
    CGSize introSize = [introString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:midFont]}];
    _introLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame) + 10, titleWidth, introSize.height);
    
    //最新内容
    CGFloat contentWidth = self.width - CGRectGetMaxX(_headImageView.frame) - 15 - 10 - 10;
    NSString *contentString = @"文章|孩子不爱说话是什么原因";
    CGSize contentSize = [contentString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:midFont]}];
    _contentLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_headImageView.frame) - contentSize.height, contentWidth, contentSize.height);
    
    //更新时间
    NSString *timeString = @"5小时前更新";
    CGSize timeSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:smallFont]}];
    _refreshTimeLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMinY(_contentLabel.frame) - 10 - (timeSize.height + 10), timeSize.width + 10, timeSize.height + 10);
    _refreshTimeLabel.layer.cornerRadius = 5;
    _refreshTimeLabel.layer.borderWidth = 0.5f;
    _refreshTimeLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setImageString:(NSString *)imageString{
    if (_imageString != imageString) {
        _imageString = imageString;
        _headImageView.image = [UIImage imageNamed:_imageString];;
    }
}

@end
