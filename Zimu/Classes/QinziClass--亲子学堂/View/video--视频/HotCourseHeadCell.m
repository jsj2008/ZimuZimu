//
//  HotCourseHeadCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HotCourseHeadCell.h"

@interface HotCourseHeadCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HotCourseHeadCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _titleLabel.text = @"推荐课程";
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(10, 0, kScreenWidth - 20, self.height);
}


@end
