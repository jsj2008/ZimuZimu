//
//  SettingView.h
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingViewDelegate <NSObject>

@optional
//显示
- (void)settingViewDidShow;

//关闭
- (void)settingViewDidHidden;

@end

@interface SettingView : UIVisualEffectView

+ (instancetype)showToView:(UIView *)view;

- (void)animation;

@property (nonatomic, weak) id<SettingViewDelegate> delegate;

@end
