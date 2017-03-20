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

@end
