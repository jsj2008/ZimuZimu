//
//  SegmentView.m
//  Zimu
//
//  Created by Redpower on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SegmentView.h"
#import "ListSelectButton.h"

@interface SegmentView ()

@property (nonatomic, strong) NSArray *segmentArray;
@property (nonatomic, strong) UIButton *selectButton;

@end

@implementation SegmentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _segmentArray = @[@"全部",@"附近",@"智能排序"];
        [self setupItems];
        
        CALayer *seperateLine = [[CALayer alloc]init];
        seperateLine.frame = CGRectMake(0, self.height - 1, self.width, 1);
        seperateLine.backgroundColor = themeGray.CGColor;
        [self.layer addSublayer:seperateLine];
    }
    return self;
}

- (void)setupItems{
    CGFloat width = self.width / _segmentArray.count;
    CGFloat height = self.height;
    for (int index = 0; index < _segmentArray.count; index++) {
        ListSelectButton *button = [[ListSelectButton alloc]initWithFrame:CGRectMake(width * index, 0, width, height) title:_segmentArray[index] imageName:@"huodong_xiala" target:self action:@selector(selectButtonAction:)];
        button.frame = CGRectMake(width * index, 0, width, height);
        [button setTitleColor:[UIColor colorWithHexString:@"222222"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"222222"] forState:UIControlStateSelected];
        button.ZMImageSite = ZMImageSiteRight;
        [self addSubview:button];
    }
}

- (void)selectButtonAction:(ListSelectButton *)button{
    _selectButton = button;
    NSLog(@"%@",button.titleLabel.text);
}

@end
