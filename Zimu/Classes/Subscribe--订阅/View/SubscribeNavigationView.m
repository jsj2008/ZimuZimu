//
//  SubscribeNavigationView.m
//  Zimu
//
//  Created by Redpower on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeNavigationView.h"

@interface SubscribeNavigationView ()


@end
@implementation SubscribeNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        [self addSubview:self.searchButton];
        [self addSubview:self.titleView];
    }
    return self;
}

//搜索按钮
- (UIButton *)searchButton{
    _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_searchButton setImage:[UIImage imageNamed:@"home_search_icon"] forState:UIControlStateNormal];
    _searchButton.frame = CGRectMake(15, (self.bounds.size.height - 20 - 30)/2.0 + 20, 30, 30);
    [_searchButton addTarget:self action:@selector(searchButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return _searchButton;
}

- (void)searchButtonAction{
    NSLog(@"subscribe search");
}

//标题栏
- (UIView *)titleView{
    CGFloat titleViewX = CGRectGetMaxX(_searchButton.frame) + 10;
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(titleViewX, 20, kScreenWidth - titleViewX * 2, 44)];
    _titleView.backgroundColor = [UIColor clearColor];
    
    //指示器
    _indicatorView = [[UIView alloc]init];
    _indicatorView.backgroundColor = themeYellow;
    _indicatorView.height = 2;
    _indicatorView.y = _titleView.height - _indicatorView.height;
    [_titleView addSubview:_indicatorView];
    
    UIButton *subscribedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [subscribedButton setTitle:@"已订"forState:UIControlStateNormal];
    [subscribedButton setTitleColor:themeBlack forState:UIControlStateNormal];
    [subscribedButton setTitleColor:themeYellow forState:UIControlStateDisabled];
    subscribedButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [subscribedButton addTarget:self action:@selector(selectSubscribed:) forControlEvents:UIControlEventTouchUpInside];
    subscribedButton.frame = CGRectMake(CGRectGetWidth(_titleView.frame)/2.0 - 60, (_titleView.height - 30)/2.0, 60, 30);
    [_titleView addSubview:subscribedButton];
    
    UIButton *recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [recommendButton setTitle:@"推荐"forState:UIControlStateNormal];
    [recommendButton setTitleColor:themeBlack forState:UIControlStateNormal];
    [recommendButton setTitleColor:themeYellow forState:UIControlStateDisabled];
    recommendButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [recommendButton addTarget:self action:@selector(selectRecommend:) forControlEvents:UIControlEventTouchUpInside];
    recommendButton.frame = CGRectMake(CGRectGetWidth(_titleView.frame)/2.0, (_titleView.height - 30)/2.0, 60, 30);
    [_titleView addSubview:recommendButton];
    
    //默认选中的是推荐
    recommendButton.enabled = NO;
    _selectButton = recommendButton;
    [recommendButton layoutIfNeeded];
    _indicatorView.width = _selectButton.titleLabel.width;
    _indicatorView.centerX = _selectButton.centerX;
    
    return _titleView;
}

//已订
- (void)selectSubscribed:(UIButton *)button{
    _selectButton.enabled = YES;
    button.enabled = NO;
    _selectButton = button;
    [self layoutIfNeeded];
    
    //移动指示器
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.3 options:
     UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
         _indicatorView.width = _selectButton.titleLabel.width;
         _indicatorView.centerX = _selectButton.centerX;
     } completion:^(BOOL finished) {
         
     }];
    
    [self.delegate showSubscribedExpertView];
}

//推荐
- (void)selectRecommend:(UIButton *)button{
    _selectButton.enabled = YES;
    button.enabled = NO;
    _selectButton = button;
    [self layoutIfNeeded];
    //移动指示器
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.75 initialSpringVelocity:0.3 options:
     UIViewAnimationOptionAllowUserInteraction | UIViewAnimationOptionBeginFromCurrentState animations:^{
         _indicatorView.width = _selectButton.titleLabel.width;
         _indicatorView.centerX = _selectButton.centerX;

     } completion:^(BOOL finished) {
         
     }];
    [self.delegate showRecommendExpertView];
}

@end
