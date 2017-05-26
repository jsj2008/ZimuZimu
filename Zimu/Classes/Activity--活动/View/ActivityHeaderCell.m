//
//  ActivityHeaderCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ActivityHeaderCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface ActivityHeaderCell ()

@property (nonatomic, strong) UIImageView *activityImageView;   //活动图片
@property (nonatomic, strong) UILabel *titleLabel;      //标题label
@property (nonatomic, strong) UILabel *introLabel;      //介绍label
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
    
    //活动图片
    _activityImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_activityImageView];
    
    //标题label
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    _titleLabel.textColor = [UIColor colorWithHexString:@"333333"];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
    
    //介绍label
    _introLabel = [[UILabel alloc]init];
    _introLabel.font = [UIFont systemFontOfSize:14];
    _introLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _introLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_introLabel];
    
    //价格label
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
}


- (void)layoutSubviews{
    [super layoutSubviews];

    //活动封面图片
    CGFloat imageHeight = 345 * kScreenWidth / 375.0;
    [_activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.height.mas_equalTo(imageHeight);
        
    }];
    
    //标题
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).with.offset(13);
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.top.mas_equalTo(_activityImageView.mas_bottom).with.offset(15);
    }];
    
    //介绍
    [_introLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_titleLabel.mas_left);
        make.right.mas_equalTo(self.mas_right).with.offset(-10);
        make.top.mas_equalTo(_titleLabel.mas_bottom).with.offset(10);
    }];

    //价格label
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(_activityImageView.mas_bottom).with.offset(10);
    }];
    
}

- (void)setActivityCategoryInfoModel:(ActivityCategoryInfoModel *)activityCategoryInfoModel{
    _activityCategoryInfoModel = activityCategoryInfoModel;
    
    NSString *imgURLString = [imagePrefixURL stringByAppendingString:activityCategoryInfoModel.imgUrl];
    [_activityImageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:@"activity_list1"]];
    
    _titleLabel.text = activityCategoryInfoModel.courseName;
    
    _introLabel.text = activityCategoryInfoModel.courseIntro;
    
}

- (void)setCoursePrice:(NSString *)coursePrice{
    NSString *string = [NSString stringWithFormat:@"%@元",coursePrice];
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc]initWithString:string attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"F5CD13"]}];
    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:25] range:NSMakeRange(0, string.length - 1)];
    _priceLabel.attributedText = attributeString;
}


@end
