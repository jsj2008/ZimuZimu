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
#import "CareQuestionApi.h"
#import "QuestionDetailModel.h"
#import "MBProgressHUD+MJ.h"
#import "NewLoginViewController.h"

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
        
        //关怀
        _likeButton.frame = layoutFrame.likeButtonFrame;
        [_likeButton setTitle:[NSString stringWithFormat:@" %@",layoutFrame.model.careNum] forState:UIControlStateNormal];
        
        //评论
        _commentButton.frame = layoutFrame.commentButtonFrame;
        [_commentButton setTitle:[NSString stringWithFormat:@" %@",layoutFrame.model.count] forState:UIControlStateNormal];

        //分享
        _shareButton.frame = layoutFrame.shareButtonFrame;

    }
}

- (void)setCareState:(NSInteger)careState{
    _likeButton.selected = careState;
}

- (IBAction)likeButtonAction:(UIButton *)sender {
    [self careQuestion];
}
//关怀问题
- (void)careQuestion{
    CareQuestionApi *careQuestionApi = [[CareQuestionApi alloc]initWithQuestionId:_layoutFrame.model.questionId];
    [careQuestionApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        NSData *data = request.responseData;
        NSError *error = nil;
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (error) {
            [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];
            return ;
        }
        BOOL isTrue = [dataDic[@"isTrue"] boolValue];
        if (!isTrue) {
            [MBProgressHUD showMessage_WithoutImage:dataDic[@"message"] toView:nil];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.0];
            return;
        }
        QuestionModel *questionModel = [QuestionModel yy_modelWithDictionary:dataDic[@"object"]];
        ConfuseContentCellLayoutFrame *layoutFrame = [[ConfuseContentCellLayoutFrame alloc]initWithModel:questionModel];
        self.layoutFrame = layoutFrame;
        _likeButton.selected = !_likeButton.selected;
        if (_likeButton.selected) {
            [MBProgressHUD showMessage_WithoutImage:@"关注成功" toView:nil];
        }else{
            [MBProgressHUD showMessage_WithoutImage:@"取消关注" toView:nil];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [MBProgressHUD showMessage_WithoutImage:@"服务器开小差了，请稍后再试" toView:nil];
    }];
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

#pragma mark -  login
- (void)login{
    NewLoginViewController *loginVC = [[NewLoginViewController alloc]init];
    [self.viewController presentViewController:loginVC animated:YES completion:nil];
}


@end
