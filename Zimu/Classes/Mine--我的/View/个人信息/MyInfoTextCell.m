//
//  MyInfoTextCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyInfoTextCell.h"
#import <Masonry.h>

@implementation MyInfoTextCell

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
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    //标题
    _titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_titleLabel];
    
    //内容
    _detailLabel = [[UILabel alloc]init];
    [self.contentView addSubview:_detailLabel];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.centerY.equalTo(self);
    }];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.textColor = [UIColor blackColor];
    
    //内容
    [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-32);
        make.left.mas_equalTo(100);
        make.centerY.equalTo(self);
    }];
    _detailLabel.font = [UIFont systemFontOfSize:15];
    _detailLabel.textAlignment = NSTextAlignmentRight;
    _detailLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _detailLabel.numberOfLines = 0;
    
}


@end
