//
//  RecommendExpertViewController.m
//  Zimu
//
//  Created by Redpower on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "RecommendExpertViewController.h"
#import "UIColor+FlatColors.h"
#import "ZLSwipeableView.h"
#import "CardView.h"

@interface RecommendExpertViewController ()<ZLSwipeableViewDataSource, ZLSwipeableViewDelegate>

@property (nonatomic, strong) ZLSwipeableView *swipeableView;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) NSInteger imageIndex;


@end

@implementation RecommendExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = themeWhite;
    
    [self setupSwipeableView];
}

- (void)setupSwipeableView{
    CGFloat x = kScreenWidth * 30/320.0;
    CGFloat width = kScreenWidth - 2 * x;
    CGFloat height = width / 0.7;
    CGFloat y = (kScreenHeight - 49 - 64 - height)/2.0;
    _swipeableView = [[ZLSwipeableView alloc]initWithFrame:CGRectMake(x, y, width, height)];
    NSLog(@"size : %lf  %lf",_swipeableView.size.width, _swipeableView.size.height);
    _swipeableView.delegate = self;
    _swipeableView.dataSource = self;
    _swipeableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_swipeableView];
    
    _imageIndex = 0;
    _images = @[
                @"home_video1",
                @"home_video2",
                @"home_video3",
                @"yiding_meirikan_pic",
                @"cycle_08.jpg",
                ];
}

- (void)viewDidLayoutSubviews{
    [self.swipeableView loadViewsIfNeeded];
}

#pragma mark - ZLSwipeableViewDataSource

- (UIView *)nextViewForSwipeableView:(ZLSwipeableView *)swipeableView {
    if (self.imageIndex >= self.images.count) {
        self.imageIndex = 0;
    }
    
    CardView *view = [[CardView alloc] initWithFrame:_swipeableView.bounds];
    view.backgroundColor = themeWhite;
    view.imageString = _images[_imageIndex];
    view.index = _imageIndex;
    _imageIndex++;
    return view;
}


#pragma mark - ()

//delegate
- (void)swipeableView:(ZLSwipeableView *)swipeableView didSwipeView:(UIView *)view inDirection:(ZLSwipeableViewDirection)direction{
    NSLog(@"direction : %zd",direction);
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didCancelSwipe:(UIView *)view{
    NSLog(@"取消swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didStartSwipingView:(UIView *)view atLocation:(CGPoint)location{
    NSLog(@"开始swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView swipingView:(UIView *)view atLocation:(CGPoint)location translation:(CGPoint)translation{
    NSLog(@"正在swipe");
}

- (void)swipeableView:(ZLSwipeableView *)swipeableView didEndSwipingView:(UIView *)view atLocation:(CGPoint)location{
    NSLog(@"结束swipe");
}


@end
