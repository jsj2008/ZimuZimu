//
//  HomeArticleCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeArticleCell.h"

@interface HomeArticleCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *articleImageView;
@property (weak, nonatomic) IBOutlet UILabel *introLabel;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIView *footerView;

- (IBAction)collectButton:(UIButton *)sender;
- (IBAction)commentButton:(UIButton *)sender;
- (IBAction)likeButton:(UIButton *)sender;
- (IBAction)moreButton:(UIButton *)sender;

@end

@implementation HomeArticleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    //分割线
    _seperateLine.backgroundColor = themeGray;
    
    _footerView.backgroundColor = themeGray;
    
    
}

- (void)layoutSubviews{
    CGFloat buttonWidth = kScreenWidth/4.0;
    CGFloat buttonHeight = 40/375.0 * kScreenWidth;
    CALayer *collectRightLayer = [[CALayer alloc]init];
    collectRightLayer.frame = CGRectMake(buttonWidth - 1, 3, 1, buttonHeight - 5);
    NSLog(@"_collectButton : %lf",_collectButton.width);
    collectRightLayer.backgroundColor = themeGray.CGColor;
    //收藏按钮
    [_collectButton.layer addSublayer:collectRightLayer];
    
    CALayer *commentRightLayer = [[CALayer alloc]init];
    commentRightLayer.frame = CGRectMake(buttonWidth - 1, 3, 1, buttonHeight - 5);
    commentRightLayer.backgroundColor = themeGray.CGColor;
    //评论按钮
    [_commentButton.layer addSublayer:commentRightLayer];
    
    CALayer *likeRightLayer = [[CALayer alloc]init];
    likeRightLayer.frame = CGRectMake(buttonWidth - 1, 3, 1, buttonHeight - 5);
    likeRightLayer.backgroundColor = themeGray.CGColor;
    //点赞按钮
    [_likeButton.layer addSublayer:likeRightLayer];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)collectButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)commentButton:(UIButton *)sender {
//    sender.selected = !sender.selected;
}

- (IBAction)likeButton:(UIButton *)sender {
    sender.selected = !sender.selected;
}

- (IBAction)moreButton:(UIButton *)sender {
//    sender.selected = !sender.selected;
}



@end
