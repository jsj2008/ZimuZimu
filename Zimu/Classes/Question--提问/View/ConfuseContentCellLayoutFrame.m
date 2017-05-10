//
//  ConfuseContentCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ConfuseContentCellLayoutFrame.h"
#import "WXLabel.h"

@implementation ConfuseContentCellLayoutFrame

- (instancetype)initWithModel:(QuestionModel *)model{
    self = [super init];
    if (self) {
        _model = model;
        [self layoutFrame];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrameNormal];
    }
    return self;
}

- (void)layoutFrameNormal{
    //问题标题
    NSString *titleString = @"困惑啊";
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _titleLabelFrame = CGRectMake(10, 10, kScreenWidth - 20, titleSize.height);
    
    
    //问题内容
    NSString *contentString = @"北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司";
    CGFloat height = [WXLabel getTextHeight:14 width:kScreenWidth - 20 text:contentString linespace:1];
    _contentLabelFrame = CGRectMake(10, CGRectGetMaxY(_titleLabelFrame) + 10, kScreenWidth - 20, height);
    
    //分割线
    _seperateLineFrame = CGRectMake(0, CGRectGetMaxY(_contentLabelFrame) + 10, kScreenWidth, 1);
    
    //点赞
    _likeButtonFrame = CGRectMake(0, CGRectGetMaxY(_seperateLineFrame), kScreenWidth/3.0, 45);
    
    //评论
    _commentButtonFrame = CGRectMake(CGRectGetMaxX(_likeButtonFrame), CGRectGetMinY(_likeButtonFrame), kScreenWidth/3.0, 45);
    
    //分享
    _shareButtonFrame = CGRectMake(CGRectGetMaxX(_commentButtonFrame), CGRectGetMinY(_likeButtonFrame), kScreenWidth/3.0, 45);
    
    //cell高度
    _cellHeight = CGRectGetMaxY(_shareButtonFrame);
    
}


- (void)layoutFrame{
    //问题标题
    NSString *titleString = _model.questionTitle;
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _titleLabelFrame = CGRectMake(10, 5, kScreenWidth - 20, titleSize.height);
    
    //问题内容
    NSString *contentString = _model.questionVal;
    CGFloat height = [WXLabel getTextHeight:14 width:kScreenWidth - 20 text:contentString linespace:1];
    _contentLabelFrame = CGRectMake(10, CGRectGetMaxY(_titleLabelFrame) + 10, kScreenWidth - 20, height);
    
    //分割线
    _seperateLineFrame = CGRectMake(0, CGRectGetMaxY(_contentLabelFrame) + 10, kScreenWidth, 1);
    
    //点赞
    _likeButtonFrame = CGRectMake(0, CGRectGetMaxY(_seperateLineFrame), kScreenWidth/3.0, 45);
    
    //评论
    _commentButtonFrame = CGRectMake(CGRectGetMaxX(_likeButtonFrame), CGRectGetMinY(_likeButtonFrame), kScreenWidth/3.0, 45);
    
    //分享
    _shareButtonFrame = CGRectMake(CGRectGetMaxX(_commentButtonFrame), CGRectGetMinY(_likeButtonFrame), kScreenWidth/3.0, 45);
    
    //cell高度
    _cellHeight = CGRectGetMaxY(_shareButtonFrame);
    
}


@end
