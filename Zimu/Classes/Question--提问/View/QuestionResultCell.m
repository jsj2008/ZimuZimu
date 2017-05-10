//
//  QuestionResultCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionResultCell.h"

@interface QuestionResultCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *answeredLabel;        //专家已解答
@property (weak, nonatomic) IBOutlet UILabel *countLabel;           //评论数量


@end

@implementation QuestionResultCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)setTitleString:(NSString *)titleString{
//    if (_titleString != titleString) {
//        _titleString = titleString;
//        _titleLabel.text = _titleString;
//    }
//}

- (void)setModel:(SearchQuestionResultModel *)model{
    if (_model != model) {
        _model = model;
        
        _titleLabel.text = model.questionTitle;
        _countLabel.text = [NSString stringWithFormat:@"*%@条评论",model.commentNum];
        if (model.commentNum == nil) {
            _countLabel.text = @"*0条评论";
        }
        NSInteger isExpertAnswer = [model.isExpAnswer integerValue];
        if (isExpertAnswer == 1) {
            _answeredLabel.text = @"*专家已解答";
        }else if (isExpertAnswer == 0){
            _answeredLabel.text = @"*专家未解答";
        }
    }
}


@end
