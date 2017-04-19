//
//  QANiceQuestionCellLayout.m
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QANiceQuestionCellLayout.h"
#import "WXLabel.h"

static NSInteger largeFont = 15;
static NSInteger midFont = 14;
static NSInteger smallFont = 13;
@implementation QANiceQuestionCellLayout

- (instancetype)initWithQuestionImage:(BOOL)hasQuestionImage{
    if (self = [super init]) {
        _hasQuestionImage = hasQuestionImage;
        [self layoutFrames];
    }
    return self;
}

- (void)layoutFrames{
    //头像
    _headImageViewFrame = CGRectMake(10, 10, 50, 50);
    
    //姓名
    NSString *nameString = @"吴三桂爱小宝啊";
    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:largeFont]}];
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), nameSize.width, nameSize.height);
    
    //发布时间
    NSString *timeString = @"2017-03-16 16:07";
    CGSize timeSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:smallFont]}];
    _timeLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_headImageViewFrame) - timeSize.height, timeSize.width, timeSize.height);
    
    //问题标题
    NSString *titleString = @"如何高效管理时间和精力？如何成为人群中最出色的2%";
    CGFloat titleWidth = kScreenWidth - CGRectGetMinX(_headImageViewFrame) * 2;
    CGFloat titleHeight = [WXLabel getTextHeight:largeFont width:titleWidth text:titleString linespace:2];
    _titleLabelFrame = CGRectMake(CGRectGetMinX(_headImageViewFrame), CGRectGetMaxY(_headImageViewFrame) + 15, titleWidth, titleHeight);
    
    //问题图片
    if (_hasQuestionImage) {
        CGFloat questionImageWidth = kScreenWidth - CGRectGetMinX(_headImageViewFrame) * 2;
        _questionImageViewFrame = CGRectMake(CGRectGetMinX(_headImageViewFrame), CGRectGetMaxY(_titleLabelFrame) + 10, questionImageWidth, questionImageWidth * 0.618);
    }else{
        _questionImageViewFrame = CGRectZero;
    }
    
    //专家回答
    NSString *answerString = @"\t陌生领域如何快速跨界打通？六年六本畅销吴军有哪些写作心得?\n\t孩子和父母的选择不一样，家长该怎么办？\n\t吴军生命中最重要的几次抉择是什么？吴军交朋友有哪些准则？";
    CGFloat answerWidth = kScreenWidth - CGRectGetMinX(_headImageViewFrame) * 2;
    CGFloat answerHeight = [WXLabel getTextHeight:midFont width:answerWidth text:answerString linespace:2];
    if (_hasQuestionImage) {
        _answerLabelFrame = CGRectMake(CGRectGetMinX(_headImageViewFrame), CGRectGetMaxY(_questionImageViewFrame) + 10, answerWidth, answerHeight);
    }else{
        _answerLabelFrame = CGRectMake(CGRectGetMinX(_headImageViewFrame), CGRectGetMaxY(_titleLabelFrame) + 10, answerWidth, answerHeight);
    }
    
    //分割线
    _separateLineFrame = CGRectMake(0, CGRectGetMaxY(_answerLabelFrame) + 10, kScreenWidth, 10);
    
    _cellHeight = CGRectGetMaxY(_separateLineFrame);
}

@end
