//
//  QANiceQuestionCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QANiceQuestionCell.h"
#import "WXLabel.h"

static NSInteger largeFont = 15;
static NSInteger midFont = 14;
static NSInteger smallFont = 13;

@interface QANiceQuestionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *questionImageView;
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
@property (weak, nonatomic) IBOutlet UIView *seperateLine;


@end

@implementation QANiceQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



- (void)setQANiceQuestionCellLayout:(QANiceQuestionCellLayout *)QANiceQuestionCellLayout{
    if (_QANiceQuestionCellLayout != QANiceQuestionCellLayout) {
        _QANiceQuestionCellLayout = QANiceQuestionCellLayout;
        
        //头像
        _headImageView.frame = _QANiceQuestionCellLayout.headImageViewFrame;
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.width/2.0;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.image = [UIImage imageNamed:@"home_FM1"];
        
        //姓名
        _nameLabel.textColor = themeBlack;
        NSString *nameString = @"吴三桂爱小宝啊";
        _nameLabel.text = nameString;
        _nameLabel.frame = _QANiceQuestionCellLayout.nameLabelFrame;
        
        //发布时间
        NSString *timeString = @"2017-03-16 16:07";
        _timeLabel.text = timeString;
        _timeLabel.frame = _QANiceQuestionCellLayout.timeLabelFrame;
        
        //问题标题
        NSString *titleString = @"如何高效管理时间和精力？如何成为人群中最出色的2%";
        _titleLabel.text = titleString;
        _titleLabel.frame = _QANiceQuestionCellLayout.titleLabelFrame;
        
        //问题图片
        _questionImageView.image = [UIImage imageNamed:@"cycle_08.jpg"];
        _questionImageView.frame = _QANiceQuestionCellLayout.questionImageViewFrame;
        
        //专家回答
        NSString *answerString = @"\t陌生领域如何快速跨界打通？六年六本畅销书，吴军有哪些写作心得？\n\t孩子和父母的选择不一样，家长该怎么办？\n\t吴军生命中最重要的几次抉择是什么？吴军交朋友有哪些准则？";
        _answerLabel.text = answerString;
        _answerLabel.frame = _QANiceQuestionCellLayout.answerLabelFrame;
        
        //底部分割线
        _seperateLine.backgroundColor = themeGray;
        _seperateLine.frame = _QANiceQuestionCellLayout.separateLineFrame;
        
    }
}


@end
