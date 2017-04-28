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

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrame];
    }
    return self;
}


- (void)layoutFrame{
    NSString *titleString = @"标题：暴躁的孩子应该怎么教育";
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _titleLabelFrame = CGRectMake(10, 10, kScreenWidth - 20, titleSize.height);
    
    NSString *contentString = @"暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育暴躁的孩子应该怎么教育";
    CGFloat height = [WXLabel getTextHeight:14 width:kScreenWidth - 20 text:contentString linespace:1];
    _contentLabelFrame = CGRectMake(10, CGRectGetMaxY(_titleLabelFrame) + 10, kScreenWidth - 20, height);
    
    _cellHeight = CGRectGetMaxY(_contentLabelFrame) + 10;
    
}


@end
