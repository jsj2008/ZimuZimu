//
//  RecommendQuestionLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/6/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "RecommendQuestionLayoutFrame.h"

@implementation RecommendQuestionLayoutFrame

- (instancetype)initWithModel:(RecommendQuestionModel *)model{
    self = [super init];
    if (self) {
        _model = model;
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    //标题
    NSString *title = _model.questionTitle;
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _titleLabelFrame = CGRectMake(10, 10, kScreenWidth - 20, size.height);
    
    //内容
    _contentLabelFrame = CGRectMake(10, CGRectGetMaxY(_titleLabelFrame) + 5, kScreenWidth - 20, size.height * 2 + 5);
    
    //专家已解答
    NSString *strng = @"*专家已解答";
    size = [strng sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _answerLabelFrame = CGRectMake(10, CGRectGetMaxY(_contentLabelFrame) + 5, size.width, size.height);
    
    //评论数量
    _countLabelFrame = CGRectMake(CGRectGetMaxX(_answerLabelFrame) + 40, CGRectGetMinY(_answerLabelFrame), 100, size.height);
    
    _cellHeight = CGRectGetMaxY(_countLabelFrame) + 10;
    
}


@end
