//
//  FMDeatilCommentCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDeatilCommentCell.h"
#import "UIImage+ZMExtension.h"

@interface FMDeatilCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton    *likeButton;
@property (weak, nonatomic) IBOutlet UILabel     *commentLabel;


@end

@implementation FMDeatilCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setCommentLayoutFrame:(FMDetailCommentLayoutFrame *)commentLayoutFrame{
    if (_commentLayoutFrame != commentLayoutFrame) {
        _commentLayoutFrame = commentLayoutFrame;
        
        //头像
        _headImageView.frame = commentLayoutFrame.headImageViewFrame;
        _headImageView.image = [UIImage imageNamed:@"mine_head_placeholder"];
//        _headImageView.image = [[UIImage imageNamed:@"mine_head_placeholder"] imageAddCornerWithRadious:_headImageView.width/2.0 size:_headImageView.size];
        
        //姓名
        _nameLabel.frame = commentLayoutFrame.nameLabelFrame;
        _nameLabel.text = @"蒙娜丽莎的微笑";
        _nameLabel.font = [UIFont systemFontOfSize:14];
        
        //点赞
        _likeButton.frame = commentLayoutFrame.likeButtonFrame;
        
        //评论内容
        NSString *commentString = @"上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的";
        _commentLabel.text = commentString;
        _commentLabel.textColor = [UIColor lightGrayColor];
        _commentLabel.font = [UIFont systemFontOfSize:13];
        _commentLabel.frame = commentLayoutFrame.commentLabelFrame;
        
    }
}

@end
