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
#import <ReactiveCocoa/ReactiveCocoa.h>

#define KHeight 260
#define cycleScrollView_height 200
#define listenButton_height 50
#define squareButtonView_height 170
#define kGap 5

@interface HomeHeaderView ()<SDCycleScrollViewDelegate, SquareButtonViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;   //轮播
@property (nonatomic, strong) UIButton *listenButton;       //清风倾听
@property (nonatomic, strong) SquareButtonView *squareButtonView;   //考试报名、试题解答、公开课程、公益众筹
@property (nonatomic, strong) CircleCollectionView *circleCollectionView;   //圆形按钮

@end

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = themeGray;
        //轮播
        [self addSubview:self.cycleScrollView];
        //清风倾听
        [self addSubview:self.listenButton];
        //考试报名、试题解答、公开课程、公益众筹
//        [self addSubview:self.squareButtonView];
        //圆形按钮
//        [self addSubview:self.circleCollectionView];
    }
    return self;
}

#pragma mark - 轮播
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
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, cycleScrollView_height) imageNamesGroup:imageUrlArray];
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}
//轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"index : %li",index);
}


#pragma mark - 清风倾听
/**
 *  清风倾听
 */
- (UIButton *)listenButton{
    if (!_listenButton) {
        _listenButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _listenButton.frame = CGRectMake(0, CGRectGetMaxY(_cycleScrollView.frame) + kGap, self.width, listenButton_height);
        [_listenButton setImage:[UIImage imageNamed:@"cycle_01.jpg"] forState:UIControlStateNormal];
        [[_listenButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            NSLog(@"listen to your heart!!!");
        }];
    }
    return _listenButton;
}


#pragma mark - 考试报名、试题解答、公开课程、公益众筹
/**
 *  考试报名、试题解答、公开课程、公益众筹
 */
- (SquareButtonView *)squareButtonView{
    if (!_squareButtonView) {
        _squareButtonView = [[SquareButtonView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_listenButton.frame) + kGap, self.width, squareButtonView_height)];
        _squareButtonView.delegate = self;
    }
    return _squareButtonView;
}
//考试报名
- (void)examApply{
    NSLog(@"考试报名");
}
//试题解答
- (void)questionAnswer{
    NSLog(@"试题解答");
}
//公开课程
- (void)openCourse{
    NSLog(@"公开课程");
}
//公益众筹
- (void)publicBenefit{
    NSLog(@"公益众筹");
}





///**
// *  圆形按钮
// */
//- (CircleCollectionView *)circleCollectionView{
//    if (!_circleCollectionView) {
//        _circleCollectionView = [[CircleCollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_squareButtonView.frame), self.width, 100)];
//        NSArray *array = @[@"cycle_03.jpg",@"cycle_04.jpg",@"cycle_05.jpg",@"cycle_06.jpg"];
//        _circleCollectionView.dataArray = array;
//    }
//    return _circleCollectionView;
//}


@end
