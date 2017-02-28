//
//  HomeHeaderView.m
//  Zimu
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"
#import "SquareButtonView.h"
#import "CircleCollectionView.h"

@interface HomeHeaderView ()<SDCycleScrollViewDelegate, SquareButtonViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;   //轮播
@property (nonatomic, strong) SquareButtonView *squareButtonView;   //在线咨询、预约专家
@property (nonatomic, strong) CircleCollectionView *circleCollectionView;   //圆形按钮

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = themeWhite;
        //轮播
        [self addSubview:self.cycleScrollView];
        //在线咨询，预约专家
        [self addSubview:self.squareButtonView];
        //圆形按钮
        [self addSubview:self.circleCollectionView];
    }
    return self;
}

/**
 *  轮播
 */
- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        NSMutableArray *imageUrlArray = [NSMutableArray array];
        for (int index = 1; index < 9; index++) {
            NSString *url = [NSString stringWithFormat:@"cycle_0%i.jpg",index];
            [imageUrlArray addObject:url];
        }
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, 200) imageNamesGroup:imageUrlArray];
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}
//轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"index : %li",index);
}

/**
 *  在线咨询、预约专家
 */
- (SquareButtonView *)squareButtonView{
    if (!_squareButtonView) {
        _squareButtonView = [[SquareButtonView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_cycleScrollView.frame), self.width, 80)];
        _squareButtonView.delegate = self;
    }
    return _squareButtonView;
}
//在线咨询
- (void)consult{
    NSLog(@"在线咨询");
}
//预约专家
- (void)appoint{
    NSLog(@"预约专家");
}

/**
 *  圆形按钮
 */
- (CircleCollectionView *)circleCollectionView{
    if (!_circleCollectionView) {
        _circleCollectionView = [[CircleCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_squareButtonView.frame), self.width, 100)];
        NSArray *array = @[@"cycle_03.jpg",@"cycle_04.jpg",@"cycle_05.jpg",@"cycle_06.jpg"];
        _circleCollectionView.dataArray = array;
    }
    return _circleCollectionView;
}


@end
