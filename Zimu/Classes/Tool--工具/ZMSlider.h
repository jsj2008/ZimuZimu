//
//  ZMSlider.h
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZMSlider : UIView

/**
 *  是否显示触摸视图(圆形触摸视图)
 */
@property (nonatomic) BOOL showTouchView;

/**
 *  圆圈视图颜色
 */
@property (nonatomic) UIColor *circleViewColor;

/**
 *  当前数值
 */
@property (nonatomic) CGFloat currentSliderValue;

/**
 *  当前数值颜色
 */
@property (nonatomic) UIColor *currentValueColor;

/**
 *  数值显示颜色
 */
@property (nonatomic) UIColor *showTextColor;

/**
 *  滑块最大取值
 */
@property (nonatomic) CGFloat maxValue;


@end
