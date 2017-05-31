//
//  MySecretCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MySecretCellLayoutFrame.h"
#import "WXLabel.h"

@interface MySecretCellLayoutFrame ()



@end

@implementation MySecretCellLayoutFrame

- (instancetype)initWithSecretModel:(SecretModel *)secretModel{
    self = [super init];
    if (self) {
        _secretModel = secretModel;
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    
    //标题
    NSString *titleString = _secretModel.questionTitle;
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _titleLabelFrame = CGRectMake(10, 15, 200, titleSize.height);
    
    //时间
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger creatTime = [_secretModel.createTime floatValue];
    creatTime /= 1000;
    CGFloat diffTime = timestamp - creatTime;
    //计算天数
    NSInteger day = diffTime / (24 * 60 * 60);
    NSString *timeString = [NSString stringWithFormat:@"%li天前",day];
    if (day == 0) {
        NSInteger hour = diffTime / (60 * 60);
        timeString = [NSString stringWithFormat:@"%li小时前",hour];
        if (hour == 0) {
            NSInteger minute = diffTime / 60;
            timeString = [NSString stringWithFormat:@"%li分前",minute];
            if (minute == 0) {
                timeString = @"刚刚";
            }
        }
    }
    CGSize timeSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _timeLabelFrame = CGRectMake(kScreenWidth - 10 - timeSize.width, CGRectGetMinY(_titleLabelFrame) + (titleSize.height - timeSize.height)/2.0, timeSize.width, timeSize.height);
    CGFloat titleWidth = CGRectGetMinX(_timeLabelFrame) - 10 - 10;
    _titleLabelFrame = CGRectMake(10, 15, titleWidth, titleSize.height);
    
    //分割线
    _seperateLineFrame = CGRectMake(10, CGRectGetMaxY(_titleLabelFrame) + 14, kScreenWidth - 10, 1);
    
    //内容
    NSString *content = _secretModel.questionVal;
    CGFloat contentHeight = [WXLabel getTextHeight:14 width:kScreenWidth - 20 text:content linespace:2];
    _contentLabelFrame = CGRectMake(10, CGRectGetMaxY(_seperateLineFrame) + 10, kScreenWidth - 20, contentHeight);
    
    //点赞
    NSString *likeString = [NSString stringWithFormat:@" %@",_secretModel.careNum];
    CGSize likeSize = [likeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _likeButtonFrame = CGRectMake(CGRectGetMinX(_contentLabelFrame), CGRectGetMaxY(_contentLabelFrame) + 10, likeSize.width + 20, likeSize.height);
    
    //评论
    NSString *commentString = [NSString stringWithFormat:@" %@",_secretModel.count];
    CGSize commentSize = [commentString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _commentButtonFrame = CGRectMake(CGRectGetMaxX(_likeButtonFrame) + 15, CGRectGetMinY(_likeButtonFrame), commentSize.width + 20, commentSize.height);
    
    //更多
    _moreImageViewFrame = CGRectMake(kScreenWidth - 10 - 10, CGRectGetMinY(_commentButtonFrame), 8, 12);
    
    //专家已解答
    NSString *stateString = @"专家已解答";
    NSInteger isExpAnswer = [_secretModel.isExpAnswer integerValue];
    if (!isExpAnswer) {
        stateString = @"专家未解答";
    }
    CGSize stateSize = [stateString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
    _answerStateButtonFrame = CGRectMake(CGRectGetMinX(_moreImageViewFrame) - stateSize.width - 2, CGRectGetMinY(_moreImageViewFrame), stateSize.width, stateSize.height);
    _moreImageViewFrame.origin.y = _answerStateButtonFrame.origin.y + (stateSize.height - _moreImageViewFrame.size.height)/2.0;
    
    
    _cellHeight = CGRectGetMaxY(_answerStateButtonFrame) + 10;
}

@end
