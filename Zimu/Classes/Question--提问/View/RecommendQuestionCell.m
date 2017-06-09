//
//  RecommendQuestionCell.m
//  Zimu
//
//  Created by Redpower on 2017/6/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "RecommendQuestionCell.h"

@interface RecommendQuestionCell ()

@property (strong, nonatomic) UILabel *titleLabel;              //标题
@property (strong, nonatomic) UILabel *answeredLabel;           //专家已解答
@property (strong, nonatomic) UILabel *countLabel;              //评论数量
@property (strong, nonatomic) UILabel *contentLabel;            //内容

@end

@implementation RecommendQuestionCell

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
    //标题
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.textColor = [UIColor colorWithHexString:@"666666"];
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    
    //内容
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.numberOfLines = 2;
    _contentLabel.textColor = [UIColor colorWithHexString:@"999999"];
    _contentLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_contentLabel];
    
    //专家是否已解答
    _answeredLabel = [[UILabel alloc]init];
    _answeredLabel.textColor = [UIColor colorWithHexString:@"AAAAAA"];
    _answeredLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_answeredLabel];
    
    //评论数
    _countLabel = [[UILabel alloc]init];
    _countLabel.textColor = [UIColor colorWithHexString:@"AAAAAA"];
    _countLabel.font = [UIFont systemFontOfSize:13];
    [self.contentView addSubview:_countLabel];
}

- (void)setLayoutFrame:(RecommendQuestionLayoutFrame *)layoutFrame{
    _titleLabel.frame = layoutFrame.titleLabelFrame;
    _titleLabel.text = layoutFrame.model.questionTitle;
    
    _contentLabel.frame = layoutFrame.contentLabelFrame;
    _contentLabel.text = layoutFrame.model.questionVal;
    
    _answeredLabel.frame = layoutFrame.answerLabelFrame;
    NSInteger isExpertAnswer = [layoutFrame.model.isExpAnswer integerValue];
    if (isExpertAnswer == 1) {
        _answeredLabel.text = @"*专家已解答";
    }else if (isExpertAnswer == 0){
        _answeredLabel.text = @"*专家未解答";
    }
    
    _countLabel.frame = layoutFrame.countLabelFrame;
    NSString *countString = layoutFrame.model.commentNum;
    if (countString == nil) {
        countString = @"0";
    }
    _countLabel.text = [NSString stringWithFormat:@"*%@条评论",countString];
    
}


@end
