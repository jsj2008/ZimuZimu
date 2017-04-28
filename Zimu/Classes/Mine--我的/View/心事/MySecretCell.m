//
//  MySecretCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MySecretCell.h"

@interface MySecretCell ()

@property (weak, nonatomic) IBOutlet UILabel    *titleLabel;                //标题
@property (weak, nonatomic) IBOutlet UILabel    *timeLabel;                 //时间
@property (weak, nonatomic) IBOutlet UIView     *seperateLine;              //分割线
@property (weak, nonatomic) IBOutlet UILabel    *contentLabel;              //内容
@property (weak, nonatomic) IBOutlet UIButton   *likeButton;                //点赞
@property (weak, nonatomic) IBOutlet UIButton   *commentButton;             //评论
@property (weak, nonatomic) IBOutlet UIButton   *answerStateButton;         //专家已解答
@property (weak, nonatomic) IBOutlet UIImageView *moreImageView;

- (IBAction)likeButtonAction:(UIButton *)sender;
- (IBAction)commentButtonAction:(UIButton *)sender;

@end

@implementation MySecretCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _seperateLine.backgroundColor = themeGray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setLayoutFrame:(MySecretCellLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        //标题
        _titleLabel.frame = layoutFrame.titleLabelFrame;
        
        //时间
        _timeLabel.frame = layoutFrame.timeLabelFrame;
        
        //分割线
        _seperateLine.frame = layoutFrame.seperateLineFrame;
        
        //内容
        _contentLabel.frame = layoutFrame.contentLabelFrame;
        
        //点赞
        _likeButton.frame = layoutFrame.likeButtonFrame;
        
        //评论
        _commentButton.frame = layoutFrame.commentButtonFrame;
        
        //更多
        _moreImageView.frame = layoutFrame.moreImageViewFrame;
        
        //专家已解答
        _answerStateButton.frame = layoutFrame.answerStateButtonFrame;
        
    }
}

- (IBAction)likeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)commentButtonAction:(UIButton *)sender {
    NSLog(@"评论");
}

@end
