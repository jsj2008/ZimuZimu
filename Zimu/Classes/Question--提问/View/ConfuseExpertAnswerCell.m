//
//  ConfuseExpertAnswerCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ConfuseExpertAnswerCell.h"
#import "UIImageView+WebCache.h"
#import "UIView+ViewController.h"
#import "ExpertDetailViewController.h"

@interface ConfuseExpertAnswerCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;        //头像
@property (weak, nonatomic) IBOutlet UIImageView *headCoverImageView;   //头像圆形覆盖
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;                //姓名
@property (weak, nonatomic) IBOutlet UILabel *tagLabel1;                //标签1
@property (weak, nonatomic) IBOutlet UILabel *tagLabel2;                //标签2
@property (weak, nonatomic) IBOutlet UIButton *advisoryButton;          //咨询
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;              //回答内容
@property (weak, nonatomic) IBOutlet UIView *seperateLine;              //分割线
@property (weak, nonatomic) IBOutlet UIButton *likeButton;              //点赞
@property (weak, nonatomic) IBOutlet UIButton *commentButton;           //评论
@property (weak, nonatomic) IBOutlet UIButton *shareButton;             //分享
- (IBAction)advisoryButtonAction:(UIButton *)sender;

@end

@implementation ConfuseExpertAnswerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _seperateLine.backgroundColor = themeGray;
    
    _tagLabel1.layer.borderWidth = 0.5f;
    _tagLabel1.layer.borderColor = [UIColor colorWithHexString:@"f5cf12"].CGColor;
    
    _tagLabel2.layer.borderWidth = 0.5f;
    _tagLabel2.layer.borderColor = [UIColor colorWithHexString:@"f5cf12"].CGColor;
    
    _seperateLine.hidden = YES;
    _likeButton.hidden = YES;
    _commentButton.hidden = YES;
    _shareButton.hidden = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setLayoutFrame:(ExpertAnswerLayoutFrame *)layoutFrame{
    if (_layoutFrame != layoutFrame) {
        _layoutFrame = layoutFrame;
        
        //头像
        _headImageView.frame = layoutFrame.headImageViewFrame;
        NSString *headImageString = [NSString stringWithFormat:@"%@%@",imagePrefixURL, layoutFrame.expertAnswerModel.userImg];
        [_headImageView sd_setImageWithURL:[NSURL URLWithString:headImageString] placeholderImage:[UIImage imageNamed:@"mine_head_placeholder"]];
        
        //头像圆形覆盖
        _headCoverImageView.frame = layoutFrame.headCoverImageViewFrame;
        
        //姓名
        _nameLabel.frame = layoutFrame.nameLabelFrame;
        _nameLabel.text = layoutFrame.expertAnswerModel.userName;
        
        //标签1
        _tagLabel1.frame = layoutFrame.tagLabel1Frame;
        _tagLabel1.layer.cornerRadius = _tagLabel1.height/2.0;
        _tagLabel1.layer.masksToBounds = YES;
        //标签2
        _tagLabel2.frame = layoutFrame.tagLabel2Frame;
        _tagLabel2.layer.cornerRadius = _tagLabel2.height/2.0;
        _tagLabel2.layer.masksToBounds = YES;
        NSArray *tagArray = [layoutFrame.expertAnswerModel.good componentsSeparatedByString:@","];
        if (tagArray == nil || tagArray.count == 0) {
            _tagLabel1.hidden = YES;
            _tagLabel2.hidden = YES;
        }else if (tagArray.count == 1){
            _tagLabel1.text = tagArray[0];
            _tagLabel2.hidden = YES;
        }else{
            _tagLabel1.text = tagArray[0];
            _tagLabel2.text = tagArray[1];
        }
        
        
        //咨询
        _advisoryButton.frame = layoutFrame.advisoryButtonFrame;
        _advisoryButton.layer.cornerRadius = _advisoryButton.height/2.0;
        _advisoryButton.layer.masksToBounds = YES;
        
        //回答内容
        _answerLabel.frame = layoutFrame.answerLabelFrame;
        _answerLabel.text = layoutFrame.expertAnswerModel.commentVal;
        
//        //分割线
//        _seperateLine.frame = layoutFrame.seperateLineFrame;
//        
//        //点赞
//        _likeButton.frame = layoutFrame.likeButtonFrame;
//        
//        //评论
//        _commentButton.frame = layoutFrame.commentButtonFrame;
//        
//        //分享
//        _shareButton.frame = layoutFrame.shareButtonFrame;
        
    }
}

- (IBAction)advisoryButtonAction:(UIButton *)sender {
    ExpertDetailViewController *expertDetailVC = [[ExpertDetailViewController alloc]init];
    [self.viewController.navigationController pushViewController:expertDetailVC animated:YES];
}




@end
