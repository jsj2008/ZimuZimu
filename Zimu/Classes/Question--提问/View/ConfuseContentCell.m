//
//  ConfuseContentCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ConfuseContentCell.h"
#import "AlignmentLabel.h"
#import "InsertCommentTableViewController.h"
#import "UIView+ViewController.h"

@interface ConfuseContentCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet AlignmentLabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

- (IBAction)likeButtonAction:(UIButton *)sender;
- (IBAction)commentButtonAction:(UIButton *)sender;
- (IBAction)shareButtonAction:(UIButton *)sender;

@end

@implementation ConfuseContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setLayoutFrameNormal:(ConfuseContentCellLayoutFrame *)layoutFrameNormal{
    if (_layoutFrameNormal != layoutFrameNormal) {
        _layoutFrameNormal = layoutFrameNormal;
        //标题
        _titleLabel.frame = layoutFrameNormal.titleLabelFrame;
        
        //内容
        _contentLabel.frame = layoutFrameNormal.contentLabelFrame;
        
        //分割线
        _seperateLine.frame = layoutFrameNormal.seperateLineFrame;
        
        //点赞
        _likeButton.frame = layoutFrameNormal.likeButtonFrame;
        
        //评论
        _commentButton.frame = layoutFrameNormal.commentButtonFrame;
        
        //分享
        _shareButton.frame = layoutFrameNormal.shareButtonFrame;
    }
}

- (void)setLayoutFrame:(ConfuseContentCellLayoutFrame *)layoutFrame {
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        //标题
        _titleLabel.frame = layoutFrame.titleLabelFrame;
        _titleLabel.text = layoutFrame.model.questionTitle;
        
        //内容
        _contentLabel.frame = layoutFrame.contentLabelFrame;
        _contentLabel.text = layoutFrame.model.questionVal;
        
        //分割线
        _seperateLine.frame = layoutFrame.seperateLineFrame;
        
        //点赞
        _likeButton.frame = layoutFrame.likeButtonFrame;
        
        //评论
        _commentButton.frame = layoutFrame.commentButtonFrame;
        
        //分享
        _shareButton.frame = layoutFrame.shareButtonFrame;

    }
}

- (IBAction)likeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)commentButtonAction:(UIButton *)sender {
    NSLog(@"评论");
    
    InsertCommentTableViewController *insertCommentVC = [[InsertCommentTableViewController alloc]init];
    insertCommentVC.questionId = _layoutFrame.model.questionId;
    [self.viewController.navigationController pushViewController:insertCommentVC animated:YES];
    
}

- (IBAction)shareButtonAction:(UIButton *)sender {
    NSLog(@"分享");
}
@end
