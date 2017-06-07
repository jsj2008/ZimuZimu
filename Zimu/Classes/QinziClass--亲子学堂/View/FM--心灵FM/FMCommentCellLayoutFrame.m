//
//  FMCommentCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMCommentCellLayoutFrame.h"
#import "WXLabel.h"

@implementation FMCommentCellLayoutFrame

//- (instancetype)init{
//    self = [super init];
//    if (self) {
//        [self layoutFrames];
//    }
//    return self;
//}

//- (void)layoutFrames{
//    //头像
//    CGFloat headImageViewWidth = 35/375.0 * kScreenWidth;
//    _headImageViewFrame = CGRectMake(10, 10, headImageViewWidth, headImageViewWidth);
//    
//    _coverImageViewFrame = _headImageViewFrame;
//    
//    //姓名
//    NSString *nameString = @"你是我的梦";
//    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
//    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), nameSize.width, nameSize.height);
//
//    
//    //评论内容
//    NSString *commentString = @"音乐，让我在悲伤时感到一丝快乐，让我感动时潸然泪下。";
//    CGFloat commentWidth = kScreenWidth - CGRectGetMinX(_nameLabelFrame) - 10;
//    CGFloat commentHeight = [WXLabel getTextHeight:15 width:commentWidth text:commentString linespace:2];
//    _commentLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 10, commentWidth, commentHeight);
//    
//    _cellHeight = CGRectGetMaxY(_commentLabelFrame) + 10;
//    
//}

#pragma mark - 评论
- (instancetype)initWithCommentModel:(CommentModel *)commentModel{
    self = [super init];
    if (self) {
        _commentModel = commentModel;
        [self layoutVideoFrames];
    }
    return self;
}

- (void)layoutVideoFrames{
    //头像
    CGFloat headImageViewWidth = 35/375.0 * kScreenWidth;
    _headImageViewFrame = CGRectMake(10, 10, headImageViewWidth, headImageViewWidth);
    
    _coverImageViewFrame = _headImageViewFrame;
    
    //姓名
    NSString *nameString = _commentModel.userName;
    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), nameSize.width, nameSize.height);
    
    
    //评论内容
    NSString *commentString = _commentModel.commentVal;
    CGFloat commentWidth = kScreenWidth - CGRectGetMinX(_nameLabelFrame) - 10;
    CGFloat commentHeight = [WXLabel getTextHeight:15 width:commentWidth text:commentString linespace:2];
    _commentLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 10, commentWidth, commentHeight);
    
    _cellHeight = CGRectGetMaxY(_commentLabelFrame) + 10;
    
}

@end
