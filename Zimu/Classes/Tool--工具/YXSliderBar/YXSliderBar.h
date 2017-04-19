//
//  YXSliderBar.h
//  BFXianDemo1
//
//  Created by lj on 16/6/14.
//  Copyright © 2016年 BFXian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YXSlideBarItemSelectedCallback)(NSUInteger idx);

@interface YXSliderBar : UIView

// All the titles of FDSilderBar
@property (copy, nonatomic) NSArray *itemsTitle;

// All the item's text color of the normal state
@property (strong, nonatomic) UIColor *itemColor;

// The selected item's text color
@property (strong, nonatomic) UIColor *itemSelectedColor;

// The slider color
@property (strong, nonatomic) UIColor *sliderColor;

//属性用于存储是否需要适应屏幕宽度
@property (nonatomic, assign) BOOL isFitPrinter;
// Add the callback deal when a slide bar item be selected
- (void)slideBarItemSelectedCallback:(YXSlideBarItemSelectedCallback)callback;

// Set the slide bar item at index to be selected
- (void)selectSlideBarItemAtIndex:(NSUInteger)index;
//自己重写的init方法，用于少量需要评分屏幕显示 目前2个
- (instancetype)initWithFrame:(CGRect)frame isFit:(BOOL)fit;
@end
