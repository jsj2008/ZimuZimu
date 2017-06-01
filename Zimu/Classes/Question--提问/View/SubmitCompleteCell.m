//
//  SubmitCompleteCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubmitCompleteCell.h"

@interface SubmitCompleteCell ()

@property (nonatomic, strong) UIImageView *successImageView;
@property (nonatomic, strong) UILabel *successLabel;

@end

@implementation SubmitCompleteCell

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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _successImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 45, 45, 45)];
    _successImageView.centerX = kScreenWidth/2.0;
    _successImageView.image = [UIImage imageNamed:@"pay_success"];
    [self.contentView addSubview:_successImageView];
    
    _successLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_successImageView.frame) + 15, kScreenWidth - 20, 15)];
    _successLabel.text = @"发布完成，专家24小时内进行解答";
    _successLabel.font = [UIFont systemFontOfSize:13];
    _successLabel.textAlignment = NSTextAlignmentCenter;
    _successLabel.textColor = [UIColor colorWithHexString:@"222222"];
    [self.contentView addSubview:_successLabel];
}

@end
