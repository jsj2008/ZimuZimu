//
//  SLDTextCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/3/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SLDTextCellLayoutFrame.h"
#import "WXLabel.h"

@implementation SLDTextCellLayoutFrame

- (instancetype)init{
    if (self = [super init]) {
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    //标题
    NSString *titleString = @"相关资质";
    CGSize titleSize = [titleString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    _titleLabelFrame = CGRectMake(10, 10, kScreenWidth - 20, titleSize.height);
    
    
    //内容
    NSString *contentString = @"清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师\n清华大学心理学博士\n国家二级心理咨询师\n国家心理中心认证咨询师";
    CGFloat width = kScreenWidth - 20;
    CGFloat height = [WXLabel getTextHeight:14 width:width text:contentString linespace:2];
    _contentLabelFrame = CGRectMake(10, CGRectGetMaxY(_titleLabelFrame) + 10, width, height);
    
    _cellHeight = CGRectGetMaxY(_contentLabelFrame) + 10;
    
}



@end
