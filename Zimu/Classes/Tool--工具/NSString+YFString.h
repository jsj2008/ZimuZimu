//
//  NSString+YFString.h
//  Zimu
//
//  Created by apple on 2017/3/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YFString)

//将string转成可变string并设置行间距
+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace;

@end
