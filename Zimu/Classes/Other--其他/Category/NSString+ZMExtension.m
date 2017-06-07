//
//  NSString+ZMExtension.m
//  Zimu
//
//  Created by Redpower on 2017/6/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NSString+ZMExtension.h"

@implementation NSString (ZMExtension)

/**
 *  计算文本高度
 *  text    :   待计算文本
 *  font    :   字体
 *  width   :   限制宽度
 *  返回：文本高度
 */
+ (CGFloat)getTextHeightWithText:(NSString *)text font:(UIFont *)font withWidth:(CGFloat)width{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    
    return rect.size.height;
}

@end
