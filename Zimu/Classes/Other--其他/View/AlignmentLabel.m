//
//  AlignmentLabel.m
//  Zimu
//
//  Created by Redpower on 2017/4/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "AlignmentLabel.h"

@implementation AlignmentLabel

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect rect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    rect.origin.y = bounds.origin.y;
    return rect;
}

- (void)drawTextInRect:(CGRect)rect{
    CGRect actualRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}


@end
