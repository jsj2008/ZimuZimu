//
//  SubscribeNavigationView.h
//  Zimu
//
//  Created by Redpower on 2017/3/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubscribeNavigationViewDelegate <NSObject>

- (void)showSubscribedExpertView;
- (void)showRecommendExpertView;

@end

@interface SubscribeNavigationView : UIVisualEffectView

@property (nonatomic, assign) id<SubscribeNavigationViewDelegate> delegate;

@property (nonatomic, strong) UIButton *searchButton;       //搜索按钮
@property (nonatomic, strong) UIView *titleView;            //标题栏
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIView *indicatorView;

@end
