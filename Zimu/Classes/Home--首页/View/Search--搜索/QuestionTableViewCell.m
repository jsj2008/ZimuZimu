//
//  QuestionTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionTableViewCell.h"

@interface QuestionTableViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;          //标题
@property (nonatomic, strong) UILabel *contentLabel;        //内容简介
@property (nonatomic, strong) UILabel *readCountLabel;      //阅读数
@property (nonatomic, strong) UILabel *replyCountLabel;     //回复数
@property (nonatomic, strong) UILabel *reviewLabel;         //专家已点评

@end

@implementation QuestionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //标题
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc]init];
            _titleLabel.font = [UIFont systemFontOfSize:16];
            _titleLabel.textAlignment = NSTextAlignmentLeft;
            _titleLabel.textColor = themeBlack;
            _titleLabel.numberOfLines = 2;
            [self.contentView addSubview:_titleLabel];
        }
        //内容简介
        if (!_contentLabel) {
            _contentLabel = [[UILabel alloc]init];
            _contentLabel.font = [UIFont systemFontOfSize:14];
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            _contentLabel.textColor = [UIColor lightGrayColor];
            _contentLabel.numberOfLines = 2;
            [self.contentView addSubview:_contentLabel];
        }//标题
        if (!_readCountLabel) {
            _readCountLabel = [[UILabel alloc]init];
            _readCountLabel.font = [UIFont systemFontOfSize:12];
            _readCountLabel.textAlignment = NSTextAlignmentLeft;
            _readCountLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_readCountLabel];
        }//标题
        if (!_replyCountLabel) {
            _replyCountLabel = [[UILabel alloc]init];
            _replyCountLabel.font = [UIFont systemFontOfSize:12];
            _replyCountLabel.textAlignment = NSTextAlignmentLeft;
            _replyCountLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_replyCountLabel];
        }//标题
        if (!_reviewLabel) {
            _reviewLabel = [[UILabel alloc]init];
            _reviewLabel.font = [UIFont systemFontOfSize:12];
            _reviewLabel.textAlignment = NSTextAlignmentLeft;
            _reviewLabel.textColor = [UIColor lightGrayColor];
            [self.contentView addSubview:_reviewLabel];
        }
    }
    return self;
}

- (void)setQuestionCellLayout:(QuestionCellLayout *)questionCellLayout{
    if (_questionCellLayout != questionCellLayout) {
        _questionCellLayout = questionCellLayout;
        
        _titleLabel.frame = _questionCellLayout.titleFrame;
        _titleLabel.text = @"孩子怪我干涉太多，我该怎么办？从此不管不问吗？不再管他了吗？";
        _contentLabel.frame = _questionCellLayout.contentFrame;
        _contentLabel.text = @"孩子觉得我干涉太多，稍不如意就断绝母子关系来威胁我，从情感上来说，也许我们已经彻底的对他想不出什么巴拉巴拉巴拉巴拉巴拉巴拉";
        _readCountLabel.frame = _questionCellLayout.readCountFrame;
        _readCountLabel.text = @"2000人阅读";
        _replyCountLabel.frame = questionCellLayout.replyCountFrame;
        _replyCountLabel.text = @"500人回复";
        _reviewLabel.frame = _questionCellLayout.reviewFrame;
        _reviewLabel.text = @"专家已点评";
    }
}


@end
