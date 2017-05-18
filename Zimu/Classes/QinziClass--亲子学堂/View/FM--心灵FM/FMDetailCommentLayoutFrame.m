//
//  FMDetailCommentLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDetailCommentLayoutFrame.h"
#import "WXLabel.h"

@implementation FMDetailCommentLayoutFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrames];
    }
    return self;
}

/*提问：用户评论*/
- (instancetype)initWithUserCommentModel:(UserCommentModel *)userCommentModel{
    self = [super init];
    if (self) {
        _userCommentModel = userCommentModel;
        [self layoutFrames_userComment];
    }
    return self;
}

- (void)layoutFrames{
    //头像
    CGFloat headImageViewWidth = 30/375.0 * kScreenWidth;
    _headImageViewFrame = CGRectMake(10, 10, headImageViewWidth, headImageViewWidth);
    
    //姓名
    NSString *nameString = @"蒙娜丽莎的微笑";
    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), nameSize.width, nameSize.height);
    
    //点赞
    _likeButtonFrame = CGRectMake(kScreenWidth - 80 - 10, CGRectGetMinY(_nameLabelFrame), 80, nameSize.height);
    
    //评论内容
    NSString *commentString = @"上了一堂真正的心理课，现在心情豁然开朗，终于知道这位专家为什么这么火了，都是有原因的";
    CGFloat commentWidth = kScreenWidth - CGRectGetMinX(_nameLabelFrame) - 10;
    CGFloat commentHeight = [WXLabel getTextHeight:13 width:commentWidth text:commentString linespace:2];
    _commentLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 10, commentWidth, commentHeight);
    
    _cellHeight = CGRectGetMaxY(_commentLabelFrame) + 10;
    
}


/*提问：用户评论*/
- (void)layoutFrames_userComment{
    //头像
    CGFloat headImageViewWidth = 30/375.0 * kScreenWidth;
    _headImageViewFrame = CGRectMake(10, 10, headImageViewWidth, headImageViewWidth);
    
    //姓名
    NSString *nameString = _userCommentModel.userName;
    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), nameSize.width, nameSize.height);
    
    //点赞
    NSString *countString = [NSString stringWithFormat:@" %li",_userCommentModel.dianZanNum];
    CGSize countSize = [countString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _likeButtonFrame = CGRectMake(kScreenWidth - (countSize.width + 20) - 10, CGRectGetMinY(_nameLabelFrame), countSize.width + 20, nameSize.height);
    
    //评论内容
    NSString *commentString = _userCommentModel.commentVal;
    CGFloat commentWidth = kScreenWidth - CGRectGetMinX(_nameLabelFrame) - 10;
    CGFloat commentHeight = [WXLabel getTextHeight:13 width:commentWidth text:commentString linespace:2];
    _commentLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 10, commentWidth, commentHeight);
    
    _cellHeight = CGRectGetMaxY(_commentLabelFrame) + 10;
    
}

@end
