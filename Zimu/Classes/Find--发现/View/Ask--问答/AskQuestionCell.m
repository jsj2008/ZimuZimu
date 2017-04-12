//
//  AskQuestionCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AskQuestionCell.h"
#import "AskQuestionCell.h"
#import "ListSelectButton.h"

@interface AskQuestionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentLabel;
@property (weak, nonatomic) IBOutlet ListSelectButton *enterButton;

@end
@implementation AskQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews{

    
}

- (void)setLayoutFrame:(AskQuestionCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        //头像
        _headImageView.frame = _layoutFrame.headImageViewFrame;
        _headImageView.image = [UIImage imageNamed:@"mine_head_placeholder"];
        
        //更多
        _moreButton.frame = _layoutFrame.moreButtonFrame;
        
        //姓名
        _nameLabel.frame = _layoutFrame.nameLabelFrame;
        
        //时间
        _timeLabel.frame = _layoutFrame.timeLabelFrame;
        
        //分割线
        _seperateLine.frame = _layoutFrame.seperateLineFrame;
        _seperateLine.backgroundColor = themeGray;
        
        //标题
        _titleLabel.frame = _layoutFrame.titleLabelFrame;
        
        //内容
        _contentLabel.frame = _layoutFrame.contentLabelFrame;
        _contentLabel.text = _layoutFrame.content;
        [_contentLabel sizeToFit];
        
        //点赞
        _likeButton.frame = _layoutFrame.likeButtonFrame;
        [_likeButton sizeToFit];
        
        //评论
        _commentLabel.frame = _layoutFrame.commentLabelFrame;
        _commentLabel.x = CGRectGetMaxX(_likeButton.frame) + 10;
        [_commentLabel sizeToFit];
        
        //进入详情
        _enterButton.frame = _layoutFrame.enterButtonFrame;
        _enterButton.ZMImageSite = ZMImageSiteRight;
        
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
