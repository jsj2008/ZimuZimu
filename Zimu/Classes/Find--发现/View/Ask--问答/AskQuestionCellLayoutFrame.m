//
//  AskQuestionCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AskQuestionCellLayoutFrame.h"
#import "WXLabel.h"

@implementation AskQuestionCellLayoutFrame

- (instancetype)initWithContent:(NSString *)content{
    self = [super init];
    if (self) {
        _content = content;
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    //头像
    self.headImageViewFrame = CGRectMake(10, 10, 40, 40);
    
    //更多按钮
    self.moreButtonFrame = CGRectMake(kScreenWidth - 10 - 40, 0, 40, 55);
    
    //姓名
    NSString *name = @"佚名";
    CGSize nameLabelSize = [name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    self.nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), CGRectGetMinX(_moreButtonFrame) - CGRectGetMaxX(_headImageViewFrame) - 10, nameLabelSize.height);
    
    //时间
    NSString *timeString = @"04-10 12:00";
    CGSize timeLabelSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    self.timeLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 5, timeLabelSize.width, timeLabelSize.height);
    
    //分割线
    self.seperateLineFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), 55, kScreenWidth - CGRectGetMinX(_nameLabelFrame), 1);
    
    //标题
    NSString *titleString = @"专题讲堂：如何让孩子成为学霸";
    CGSize titleLabelSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    self.titleLabelFrame = CGRectMake(10, CGRectGetMaxY(_seperateLineFrame) + 10, kScreenWidth - 10 - 10, titleLabelSize.height);
    
    //回答内容
//    NSString *contentString = @"上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的。上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的。上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的。";
    CGFloat contentHeight = [WXLabel getTextHeight:14 width:CGRectGetWidth(_titleLabelFrame) text:_content linespace:2];
    UILabel *label = [[UILabel alloc]init];
    label.text = _content;
    label.numberOfLines = 5;
    label.font = [UIFont systemFontOfSize:14];
    label.frame = CGRectMake(CGRectGetMinX(_titleLabelFrame), CGRectGetMaxY(_titleLabelFrame) + 10, CGRectGetWidth(_titleLabelFrame), contentHeight);
    [label sizeToFit];
    self.contentLabelFrame = label.frame;
    label = nil;
    [label removeFromSuperview];
    
    //点赞按钮
    self.likeButtonFrame = CGRectMake(CGRectGetMinX(_titleLabelFrame), CGRectGetMaxY(_contentLabelFrame) + 10, 80, 15);
    
    //评论
    self.commentLabelFrame = CGRectMake(CGRectGetMaxX(_likeButtonFrame) + 15, CGRectGetMinY(_likeButtonFrame), 80, 15);
    
    //专家已解答，进入问答详情
    NSString *enterString = @"专家已解答";
    CGSize enterSize = [enterString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat enterWidth = enterSize.width + 20;
    self.enterButtonFrame = CGRectMake(kScreenWidth - 10 - enterWidth, CGRectGetMinY(_likeButtonFrame), enterWidth, 15);
    
    self.cellHeight = CGRectGetMaxY(_likeButtonFrame) + 15;
    
}

@end
