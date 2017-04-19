//
//  ArticleCellLayout.m
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ArticleCellLayout.h"
#import "WXLabel.h"

@implementation ArticleCellLayout

- (instancetype)init{
    if (self = [super init]) {
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    _imageViewFrame = CGRectMake(kScreenWidth - 90 - 10, 10, 90, 90);

    CGFloat titleWidth = kScreenWidth - 10 - _imageViewFrame.size.width - 20;
    NSString *titleString = @"你的孩子为什么会不愿意和你交心？";
    CGFloat titleHeight = [WXLabel getTextHeight:15 width:titleWidth text:titleString linespace:3];
    _titleFrame = CGRectMake(10, 10, titleWidth, titleHeight);
    
    _contentFrame = CGRectMake(CGRectGetMinX(_titleFrame), CGRectGetMaxY(_titleFrame), CGRectGetWidth(_titleFrame), 35);
    
    NSString *readCountString = @"10000人浏览";
    CGSize readCountSize = [readCountString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    _readCountFrame = CGRectMake(CGRectGetMaxX(_titleFrame) - readCountSize.width, CGRectGetMaxY(_imageViewFrame) - readCountSize.height, readCountSize.width, readCountSize.height);
}

@end
