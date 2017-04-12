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
@property (nonatomic, strong) NSArray *names;
@property (nonatomic, assign) NSInteger imageIndex;
@property (nonatomic, strong) UIImageView *bgImageView;

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
                @"吴东辉.jpeg",
                @"张海顺.jpg",
                @"班小红.jpg",
                @"符梦梵.jpg",
                @"贡丽娜.jpg",
                @"何慧芬.jpg",
                @"蒋超斌.jpg",
                @"林巧云.jpg",
                @"钱宇平.jpg",
                @"王静.jpg",
                @"王敏燕.jpg",
                @"王小红.jpg",
                @"吴俊宇.jpg",
                @"席世阳.jpg",
                @"徐霞.jpg",
                @"周昕.jpg",
                @"朱霞.jpg"
                ];
    _names = @[
                @"吴东辉",
                @"张海顺",
                @"班小红",
                @"符梦梵",
                @"贡丽娜",
                @"何慧芬",
                @"蒋超斌",
                @"林巧云",
                @"钱宇平",
                @"王静",
                @"王敏燕",
                @"王小红",
                @"吴俊宇",
                @"席世阳",
                @"徐霞",
                @"周昕",
                @"朱霞"
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
    view.name = _names[_imageIndex];
    view.jobTitle = @"国家二级心理咨询师";
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
