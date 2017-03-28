//
//  UIColor+HexString.h
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)
/**
 *  十六进制的颜色转换为UIColor
 *
 *  @param color   十六进制的颜色
 *
 *  @return   UIColor
 */
+ (UIColor *)colorWithHexString:(NSString *)color;


/*
 *  色值渐变
 *
 *  ratio               :       色值比例
 *  originalColor       :       初始色十六进制色值
 *  destinationColor    :       目标色十六进制色值
 *
 *  return      UIColor
 */
+ (UIColor *)changeColorWithRatio:(CGFloat)ratio fromColor:(NSString *)originalColor toColor:(NSString *)destinationColor;

@end
