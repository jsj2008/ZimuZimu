//
//  NSString+YFString.m
//  Zimu
//
//  Created by apple on 2017/3/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "NSString+YFString.h"

@implementation NSString (YFString)
+ (NSAttributedString *)getAttributedStringWithString:(NSString *)string lineSpace:(CGFloat)lineSpace {
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpace; // 调整行间距
    NSRange range = NSMakeRange(0, [string length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    
    return attributedString;
    
}
@end
