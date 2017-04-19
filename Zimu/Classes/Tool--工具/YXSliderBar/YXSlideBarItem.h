//
//  YXSlideBarItem.h
//  BFXianDemo1
//
//  Created by lj on 16/6/14.
//  Copyright © 2016年 BFXian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXSlideBarItemDelegate;

@interface YXSlideBarItem : UIView

@property (assign, nonatomic) BOOL selected;
@property (weak, nonatomic) id<YXSlideBarItemDelegate> delegate;

- (void)setItemTitle:(NSString *)title;
- (void)setItemTitleFont:(CGFloat)fontSize;
- (void)setItemTitleColor:(UIColor *)color;
- (void)setItemSelectedTileFont:(CGFloat)fontSize;
- (void)setItemSelectedTitleColor:(UIColor *)color;

+ (CGFloat)widthForTitle:(NSString *)title;


@end

@protocol YXSlideBarItemDelegate <NSObject>

- (void)slideBarItemSelected:(YXSlideBarItem *)item;

@end
