//
//  FMDetailIntroLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMDetailIntroLayoutFrame.h"
#import "WXLabel.h"

@implementation FMDetailIntroLayoutFrame

- (instancetype)init{
    if (self = [super init]) {
        [self layoutFrames];
    }
    return self;
}

- (void)layoutFrames{
    //标签MarkLabel
    NSString *markString = @"内容简介";
    CGSize markSize = [markString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _markLabelFrame = CGRectMake(15, 10, markSize.width, markSize.height);
    
    //内容简介ContentLabel
    NSString *contentString = @"北京夏茉教育咨询有限公司的前身为本心文化传播（上海）有限公司。子慕，提供多元化的家庭情感咨询定制化服务。也是国内唯一集情感咨询、情感维护、家庭类视频制作、情感电台、书籍发行、落地式亲子活动、国家家庭教育政府项目采购、国际性幸福论坛、中国亲子家庭教育资格认定于一体的情感咨询幸福产业缔造者。";
    CGFloat contentWidth = kScreenWidth - 2 * CGRectGetMinX(_markLabelFrame);
    CGFloat contentHeight = [WXLabel getTextHeight:14 width:contentWidth text:contentString linespace:2];
    if (!_isOpening && contentHeight >= 51) {
        contentHeight = 51;         //51的高度配合14的字体刚好能显示三行
    }
    _contentLabelFrame = CGRectMake(CGRectGetMinX(_markLabelFrame), CGRectGetMaxY(_markLabelFrame) + 10, contentWidth, contentHeight);
    
    //展开按钮openButton
    CGFloat openButtonWidth = 80;
    CGFloat openButtonHeight = 30;
    _openButtonFrame = CGRectMake((kScreenWidth - openButtonWidth)/2.0, CGRectGetMaxY(_contentLabelFrame) + 5, openButtonWidth, openButtonHeight);
    
    _cellHeight = CGRectGetMaxY(_openButtonFrame) + 5;
    
}

- (void)setIsOpening:(BOOL)isOpening{
    if (_isOpening != isOpening) {
        _isOpening = isOpening;
        //重新布局
        [self layoutFrames];
    }
}


@end
