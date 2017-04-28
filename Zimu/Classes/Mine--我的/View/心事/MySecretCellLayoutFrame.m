//
//  MySecretCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MySecretCellLayoutFrame.h"
#import "WXLabel.h"


@implementation MySecretCellLayoutFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    
    //标题
    NSString *titleString = @"如何让孩子成为学霸";
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _titleLabelFrame = CGRectMake(10, 15, 200, titleSize.height);
    
    //时间
    NSString *timeString = @"7天前";
    CGSize timeSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _timeLabelFrame = CGRectMake(kScreenWidth - 10 - timeSize.width, CGRectGetMinY(_titleLabelFrame) + (titleSize.height - timeSize.height)/2.0, timeSize.width, timeSize.height);
    CGFloat titleWidth = CGRectGetMinX(_timeLabelFrame) - 10 - 10;
    _titleLabelFrame = CGRectMake(10, 15, titleWidth, titleSize.height);
    
    //分割线
    _seperateLineFrame = CGRectMake(10, CGRectGetMaxY(_titleLabelFrame) + 14, kScreenWidth - 10, 1);
    
    //内容
    NSString *content = @"上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，这一切都是有原因的。我的孩子学习成绩老师提升不上去，专家给了我很多关于教育小孩的建议，我收益颇丰，感谢这位专家！";
    CGFloat contentHeight = [WXLabel getTextHeight:14 width:kScreenWidth - 20 text:content linespace:2];
    _contentLabelFrame = CGRectMake(10, CGRectGetMaxY(_seperateLineFrame) + 10, kScreenWidth - 20, contentHeight);
    
    //点赞
    NSString *likeString = @" 1000";
    CGSize likeSize = [likeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _likeButtonFrame = CGRectMake(CGRectGetMinX(_contentLabelFrame), CGRectGetMaxY(_contentLabelFrame) + 10, likeSize.width + 20, likeSize.height);
    
    //评论
    NSString *commentString = @" 1000";
    CGSize commentSize = [commentString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _commentButtonFrame = CGRectMake(CGRectGetMaxX(_likeButtonFrame) + 15, CGRectGetMinY(_likeButtonFrame), commentSize.width + 20, commentSize.height);
    
    //更多
    _moreImageViewFrame = CGRectMake(kScreenWidth - 10 - 10, CGRectGetMinY(_commentButtonFrame), 8, 12);
    
    //专家已解答
    NSString *stateString = @"专家已解答";
    CGSize stateSize = [stateString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _answerStateButtonFrame = CGRectMake(CGRectGetMinX(_moreImageViewFrame) - stateSize.width - 2, CGRectGetMinY(_moreImageViewFrame), stateSize.width, stateSize.height);
    _moreImageViewFrame.origin.y = _answerStateButtonFrame.origin.y + (stateSize.height - _moreImageViewFrame.size.height)/2.0;
    
    
    _cellHeight = CGRectGetMaxY(_answerStateButtonFrame) + 10;
}

@end
