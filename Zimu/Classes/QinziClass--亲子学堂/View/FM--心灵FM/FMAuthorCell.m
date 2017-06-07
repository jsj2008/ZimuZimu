//
//  FMAuthorCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMAuthorCell.h"
#import <UIImageView+WebCache.h>

@interface FMAuthorCell ()

@property (nonatomic, strong) UIImageView *headImageview;       //头像
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *nameLabel;               //姓名
@property (nonatomic, strong) UILabel *introLabel;              //专家介绍
@property (nonatomic, strong) UILabel *playCountLabel;          //播放次数
@property (nonatomic, strong) UILabel *timeLabel;               //上传时间

@end

@implementation FMAuthorCell

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
    //头像
    _headImageview = [[UIImageView alloc]init];
    [self.contentView addSubview:_headImageview];
    
    //圆角
    _coverImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cycle_head"]];
    [self.contentView addSubview:_coverImageView];
    
    //姓名
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.centerY = _headImageview.centerY;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _nameLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_nameLabel];

    //播放次数
    _playCountLabel = [[UILabel alloc]init];
    _playCountLabel.font = [UIFont systemFontOfSize:11];
    _playCountLabel.textColor = [UIColor colorWithHexString:@"999999"];
    [self.contentView addSubview:_playCountLabel];
    
    //时间
    _timeLabel = [[UILabel alloc]init];
    _timeLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _timeLabel.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:_timeLabel];
    
    //专家介绍
    _introLabel = [[UILabel alloc]init];
    _introLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _introLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_introLabel];
}

- (void)setLayoutFrame:(FMAuthorCellLayoutFrame *)layoutFrame{
    _headImageview.frame = layoutFrame.headImageViewFrame;
    _coverImageView.frame = layoutFrame.coverImageViewFrame;
    _nameLabel.frame = layoutFrame.nameLabelFrame;
    _introLabel.frame = layoutFrame.introLabelFrame;
    _playCountLabel.frame = layoutFrame.countLabelFrame;
    _timeLabel.frame = layoutFrame.timeLabelFrame;
    
    _headImageview.image = [UIImage imageNamed:@"fm_head"];
    _nameLabel.text = @"";
    _playCountLabel.text = @"";
    _timeLabel.text = @"";
}

- (void)setDataLayoutFrame:(FMAuthorCellLayoutFrame *)dataLayoutFrame{
    _headImageview.frame = dataLayoutFrame.headImageViewFrame;
    _coverImageView.frame = dataLayoutFrame.coverImageViewFrame;
    _nameLabel.frame = dataLayoutFrame.nameLabelFrame;
    _introLabel.frame = dataLayoutFrame.introLabelFrame;
    
    NSString *imgURLString = dataLayoutFrame.expertDetailModel.userImg;
    if (imgURLString == nil) {
        imgURLString = @"";
    }
    imgURLString = [imagePrefixURL stringByAppendingString:imgURLString];
    [_headImageview sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:@"fm_head"]];
//    _headImageview.image = [UIImage imageNamed:@"fm_head"];
    _nameLabel.text = dataLayoutFrame.expertDetailModel.userName;
    _introLabel.text = dataLayoutFrame.expertDetailModel.expert.profile;
}

@end
