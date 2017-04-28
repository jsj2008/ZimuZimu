//
//  ExpertAnswerLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ExpertAnswerLayoutFrame.h"

@implementation ExpertAnswerLayoutFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    //头像
    _headImageViewFrame = CGRectMake(10, 10, 60, 60);
    
    //姓名
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), 100, 20);
    
    //标签1
    NSString *tagString = @"亲子关系";
    CGSize tagSize = [tagString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _tagLabel1Frame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 5, tagSize.width + 15, tagSize.height + 6);
    
    //标签2
    tagString = @"叛逆";
    tagSize = [tagString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _tagLabel2Frame = CGRectMake(CGRectGetMaxX(_tagLabel1Frame) + 10, CGRectGetMinY(_tagLabel1Frame), tagSize.width + 15, tagSize.height + 6);
    
    //咨询
    NSString *advisoryString = @"一对一咨询";
    CGSize advisorySize = [
                           advisoryString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    CGFloat advisoryWidth = advisorySize.width + 25;
    CGFloat advisoryHeight = 35;
    _advisoryButtonFrame = CGRectMake(kScreenWidth - 10 - advisoryWidth, CGRectGetMinY(_headImageViewFrame), advisoryWidth, advisoryHeight);
    
    //回答内容
    NSString *answerText = @"北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司北京子慕教育咨询有限公司的前身为本心文化传播（上海）有限公司";
    UILabel *label = [[UILabel alloc]init];
    label.numberOfLines = 4;
    label.text = answerText;
    label.font = [UIFont systemFontOfSize:14];
    label.width = kScreenWidth - 20;
    [label sizeToFit];
    _answerLabelFrame = CGRectMake(10, CGRectGetMaxY(_headImageViewFrame) + 10, kScreenWidth - 20, label.height);
    label = nil;
    
    //分割线
    _seperateLineFrame = CGRectMake(0, CGRectGetMaxY(_answerLabelFrame) + 10, kScreenWidth, 1);
    
    //点赞
    _likeButtonFrame = CGRectMake(0, CGRectGetMaxY(_seperateLineFrame), kScreenWidth/3.0, 30);
    
    //评论
    _commentButtonFrame = CGRectMake(CGRectGetMaxX(_likeButtonFrame), CGRectGetMinY(_likeButtonFrame), kScreenWidth/3.0, 30);
    
    //分享
    _shareButtonFrame = CGRectMake(CGRectGetMaxX(_commentButtonFrame), CGRectGetMinY(_likeButtonFrame), kScreenWidth/3.0, 30);
    
    
    //cell高度
    _cellHeight = CGRectGetMaxY(_likeButtonFrame);
    
}

@end
