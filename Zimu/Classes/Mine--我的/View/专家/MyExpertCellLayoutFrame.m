//
//  MyExpertCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "MyExpertCellLayoutFrame.h"

@implementation MyExpertCellLayoutFrame

- (instancetype)init{
    if (self = [super init]) {
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    //头像
    _headImageViewFrame = CGRectMake(10, 10, 60, 60);
    
    //姓名
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame), kScreenWidth - CGRectGetMaxX(_headImageViewFrame) - 20, 20);
    
    //标签1
    NSString *tag1 = @"国家二级心理咨询师";
    CGSize tagSize1 = [tag1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    _tagLabel1Frame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 2, tagSize1.width + 10, tagSize1.height + 5);
    
    //标签2
    NSString *tag2 = @"清华大学心理学教授";
    CGSize tagSize2 = [tag2 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    _tagLabel2Frame = CGRectMake(CGRectGetMaxX(_tagLabel1Frame) + 10, CGRectGetMinY(_tagLabel1Frame), tagSize2.width + 10, tagSize2.height + 5);
    
    //介绍
    _introLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_headImageViewFrame) - 15, kScreenWidth - CGRectGetMaxX(_headImageViewFrame) - 20, 15);
    
    //分割线
    _seperateLineFrame = CGRectMake(0, 85 - 1, kScreenWidth, 1);
}

@end
