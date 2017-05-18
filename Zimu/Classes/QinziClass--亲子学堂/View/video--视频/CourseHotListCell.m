//
//  CourseHotListCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseHotListCell.h"
#import <UIImageView+WebCache.h>

@interface CourseHotListCell ()

@property (strong, nonatomic) UIImageView *videoImageView;            //视频图片
@property (strong, nonatomic) UILabel *titleLabel;                    //标题

@end

@implementation CourseHotListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    //图片
    _videoImageView = [[UIImageView alloc]init];
    _videoImageView.image = [UIImage imageNamed:@"delta"];
    [self.contentView addSubview:_videoImageView];
    
    //标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _titleLabel.numberOfLines = 2;
    _titleLabel.text = @"我是我 疲倦流浪的太阳";
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //图片
    _videoImageView.frame = CGRectMake(0, 0, self.width, self.width * 0.8);
    
    //标题
    _titleLabel.frame = CGRectMake(0, CGRectGetMaxY(_videoImageView.frame) + 5, self.width, 35);
    
}

- (void)setHotVideoModel:(HotVideoModel *)hotVideoModel{
    _hotVideoModel = hotVideoModel;
    
    NSString *imgURLString = [imagePrefixURL stringByAppendingString:hotVideoModel.videoImg];
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:@"delta"]];
}

@end
