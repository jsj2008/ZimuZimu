//
//  CityCourseDetailThemeCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/4/13.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CityCourseDetailThemeCellLayoutFrame.h"
#import "WXLabel.h"

@implementation CityCourseDetailThemeCellLayoutFrame

- (instancetype)initWithThemeString:(NSString *)themeString{
    self = [super init];
    if (self) {
        _themeString = themeString;
        [self layoutFrame];
    }
    return self;
}

- (void)layoutFrame{
    
    CGFloat height = [WXLabel getTextHeight:16 width:kScreenWidth - 20 text:_themeString linespace:2];
    _themeLabelFrame = CGRectMake(10, 10, kScreenWidth - 20, height);
    
    _cellHeight = CGRectGetMaxY(_themeLabelFrame) + 10;
    
}

@end
