//
//  ActivityHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityHeaderCell.h"
#import <Masonry.h>

@interface ActivityHeaderCell ()

@property (nonatomic, strong) UIView *headerBGView;     //标题背景view
@property (nonatomic, strong) UILabel *titleLabel;      //标题label
@property (nonatomic, strong) UIImageView *activityImageView;   //活动图片
@property (nonatomic, strong) UILabel *priceLabel;      //价格label

@end

@implementation ActivityHeaderCell

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

- (void)setupUI{  //238 239 240
    //标题背景view
    _headerBGView = [[UIView alloc]init];
    _headerBGView.backgroundColor = [UIColor colorWithHexString:@"EEEFF0"];
    [self.contentView addSubview:_headerBGView];
    
    //标题label
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    _titleLabel.text = @"活动主题活动主题活动主题活动主题";
    [self.contentView addSubview:_titleLabel];
    
    //活动图片
    _activityImageView = [[UIImageView alloc]init];
    _activityImageView.image = [UIImage imageNamed:@"activity_list1"];
    [self.contentView addSubview:_activityImageView];
    
    //价格label
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"活动价格:￥500.00";
    [self.contentView addSubview:_priceLabel];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    //标题背景view
    [_headerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headerBGView.mas_left).with.offset(10);
        make.right.mas_equalTo(_headerBGView.mas_right).with.offset(-10);
        make.height.mas_equalTo(_headerBGView.mas_height);
    }];
    
    //活动图片
    CGFloat imageHeight = 140 * kScreenWidth / 375.0;
    [_activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.top.equalTo(_headerBGView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(imageHeight);
        
    }];
    
    //价格label
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_activityImageView.mas_right);
        make.top.equalTo(_activityImageView.mas_bottom).with.offset(10);
        make.width.equalTo(_activityImageView.mas_width);
    }];
    
}






@end
