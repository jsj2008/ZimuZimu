//
//  EvaluationTableViewCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "EvaluationTableViewCell.h"

@interface EvaluationTableViewCell ()

@property (nonatomic, strong) UIImageView *articleImageView;        //图片
@property (nonatomic, strong) UILabel *titleLabel;                  //标题
@property (nonatomic, strong) UILabel *contentLabel;                //内容简介
@property (nonatomic, strong) UILabel *readCountLabel;              //阅读数

@end

@implementation EvaluationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图片
        if (!_articleImageView) {
            _articleImageView = [[UIImageView alloc]init];
            _articleImageView.image = [UIImage imageNamed:@"cycle_01.jpg"];
            [self.contentView addSubview:_articleImageView];
            
        }
        //标题
        if (!_titleLabel) {
            _titleLabel =[[UILabel alloc]init];
            _titleLabel.textColor = themeBlack;
            _titleLabel.font = [UIFont systemFontOfSize:15];
            _titleLabel.textAlignment = NSTextAlignmentLeft;
            _titleLabel.numberOfLines = 0;
            [self.contentView addSubview:_titleLabel];
            
        }
        //简介内容
        if (!_contentLabel) {
            _contentLabel =[[UILabel alloc]init];
            _contentLabel.textColor = [UIColor lightGrayColor];
            _contentLabel.font = [UIFont systemFontOfSize:13];
            _contentLabel.textAlignment = NSTextAlignmentLeft;
            _contentLabel.numberOfLines = 2;
            [self.contentView addSubview:_contentLabel];
            
        }
        //浏览人数
        if (!_readCountLabel) {
            _readCountLabel =[[UILabel alloc]init];
            _readCountLabel.textColor = [UIColor lightGrayColor];
            _readCountLabel.font = [UIFont systemFontOfSize:12];
            _readCountLabel.textAlignment = NSTextAlignmentRight;
            [self.contentView addSubview:_readCountLabel];
            
        }
    }
    return self;
}

- (void)setEvaluationCellLayout:(EvaluationCellLayout *)evaluationCellLayout{
    if (_evaluationCellLayout != evaluationCellLayout) {
        _evaluationCellLayout = evaluationCellLayout;
        
        _articleImageView.frame = _evaluationCellLayout.imageViewFrame;
        
        _titleLabel.text = @"你的孩子为什么会不愿意和你交心？";
        _titleLabel.frame = _evaluationCellLayout.titleFrame;
        
        _contentLabel.text = @"孩子觉得我干涉太多，稍不如意就断绝母子关系来威胁我，从情感上来说，也许我们已经彻底的对他想不出什么巴拉巴拉巴拉巴拉巴拉巴拉";
        _contentLabel.frame = _evaluationCellLayout.contentFrame;
        
        _readCountLabel.text = @"10000人浏览";
        _readCountLabel.frame = _evaluationCellLayout.readCountFrame;
        
    }
}

@end
