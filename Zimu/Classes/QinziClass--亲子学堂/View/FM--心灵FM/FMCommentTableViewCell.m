//
//  FMCommentTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMCommentTableViewCell.h"
#import <UIImageView+WebCache.h>

@interface FMCommentTableViewCell ()

@property (nonatomic, strong) UIImageView *headImageView;       //头像
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *nameLabel;               //姓名
@property (nonatomic, strong) UILabel *commentLabel;            //评论内容

@end

@implementation FMCommentTableViewCell

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
    _headImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_headImageView];
    
    //圆形覆盖
    _coverImageView = [[UIImageView alloc]init];
    _coverImageView.image = [UIImage imageNamed:@"cycle_head"];
    [self.contentView addSubview:_coverImageView];
    
    //姓名
    _nameLabel = [[UILabel alloc]init];
    _nameLabel.font = [UIFont systemFontOfSize:13];
    _nameLabel.textColor = [UIColor colorWithHexString:@"666666"];
    [self.contentView addSubview:_nameLabel];
    
    //评论内容
    _commentLabel = [[UILabel alloc]init];
    _commentLabel.font = [UIFont systemFontOfSize:15];
    _commentLabel.textColor = [UIColor colorWithHexString:@"222222"];
    _commentLabel.numberOfLines = 0;
    [self.contentView addSubview:_commentLabel];
    
}

- (void)setLayoutFrame:(FMCommentCellLayoutFrame *)layoutFrame{
    
    _headImageView.frame = layoutFrame.headImageViewFrame;
    _coverImageView.frame = layoutFrame.coverImageViewFrame;
    _nameLabel.frame = layoutFrame.nameLabelFrame;
    _commentLabel.frame = layoutFrame.commentLabelFrame;
    
    _headImageView.image = [UIImage imageNamed:@"mine_head_placeholder"];
    _nameLabel.text = @"你是我的梦";
    _commentLabel.text = @"音乐，让我在悲伤时感到一丝快乐，让我感动时潸然泪下。";
}

- (void)setDataCommentLayoutFrame:(FMCommentCellLayoutFrame *)dataCommentLayoutFrame{
    
    _headImageView.frame = dataCommentLayoutFrame.headImageViewFrame;
    _coverImageView.frame = dataCommentLayoutFrame.coverImageViewFrame;
    _nameLabel.frame = dataCommentLayoutFrame.nameLabelFrame;
    _commentLabel.frame = dataCommentLayoutFrame.commentLabelFrame;
    
//    NSString *imgURLString = [imagePrefixURL stringByAppendingString:videoCommentLayoutFrame.videoCommentModel.userImg];
//    [_headImageView sd_setImageWithURL:[NSURL URLWithString:imgURLString] placeholderImage:[UIImage imageNamed:@"mine_head_placeholder"]];
    _headImageView.image = [UIImage imageNamed:@"mine_head_placeholder"];
    _nameLabel.text = dataCommentLayoutFrame.videoCommentModel.userName;
    _commentLabel.text = dataCommentLayoutFrame.videoCommentModel.commentVal;
}

@end
