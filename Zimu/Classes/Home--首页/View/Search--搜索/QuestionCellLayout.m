//
//  QuestionCellLayout.m
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "QuestionCellLayout.h"
#import "WXLabel.h"

@implementation QuestionCellLayout

- (instancetype)init{
    if (self = [super init]) {
        [self layoutFrames];
    }
    return self;
}

- (void)layoutFrames{
    NSString *titleString = @"孩子怪我干涉太多，我该怎么办？从此不管不问吗？不再管他了吗？";
    CGFloat titleHeight = [WXLabel getTextHeight:16 width:kScreenWidth - 20 text:titleString linespace:3];
    _titleFrame = CGRectMake(10, 5, kScreenWidth - 20, titleHeight);
    
//    NSString *contentString = @"孩子觉得我干涉太多，稍不如意就断绝母子关系来威胁我，从情感上来说，也许我们已经彻底的对他想不出什么巴拉巴拉巴拉巴拉巴拉巴拉";
    _contentFrame = CGRectMake(CGRectGetMinX(_titleFrame), CGRectGetMaxY(_titleFrame) + 5, CGRectGetWidth(_titleFrame), 40);
    
    NSString *readCountString = @"2000人阅读";
    CGSize readCountSize = [readCountString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _readCountFrame = CGRectMake(CGRectGetMinX(_titleFrame), CGRectGetMaxY(_contentFrame) + 3, readCountSize.width, readCountSize.height);
    
    NSString *replyCountString = @"500人回复";
    CGSize replyCountSize = [replyCountString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _replyCountFrame = CGRectMake(CGRectGetMaxX(_readCountFrame) + 10, CGRectGetMinY(_readCountFrame), replyCountSize.width, replyCountSize.height);
    
    NSString *reviewString = @"专家已点评";
    CGSize reviewSize = [reviewString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _reviewFrame = CGRectMake(CGRectGetMaxX(_contentFrame) - reviewSize.width, CGRectGetMinY(_readCountFrame), reviewSize.width, reviewSize.height);
    
    _cellHeight = CGRectGetMaxY(_readCountFrame) + 10;
    
}

@end
