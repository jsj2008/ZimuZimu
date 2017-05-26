//
//  ActivityChooseCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityChooseCell.h"

@interface ActivityChooseCell ()

@property (nonatomic, strong) UIImageView *arrowImageView;

@end

@implementation ActivityChooseCell

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
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
//    _titleLabel.text = @"请选择课程地点";
    [self.contentView addSubview:_titleLabel];
    
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.font = [UIFont systemFontOfSize:14];
    _contentLabel.textAlignment = NSTextAlignmentRight;
    _contentLabel.textColor = [UIColor colorWithHexString:@"999999"];
//    _contentLabel.text = @"滨江";
    [self.contentView addSubview:_contentLabel];
    
    _arrowImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"course_more"]];
    [self.contentView addSubview:_arrowImageView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _titleLabel.frame = CGRectMake(13, 0, 120, self.height);
    _arrowImageView.frame = CGRectMake(self.width - 10 - 10, (self.height - 15)/2.0, 10, 15);
    _contentLabel.frame = CGRectMake(CGRectGetMinX(_arrowImageView.frame) - 200 - 5, 0, 200, self.height);
}


@end
