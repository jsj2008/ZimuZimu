//
//  UIColor+HexString.h
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//


#import "UIColor+HexString.h"

@implementation UIColor (HexString)

+ (UIColor *)colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *)changeColorWithRatio:(CGFloat)ratio fromColor:(NSString *)originalColor toColor:(NSString *)destinationColor{
    NSString *originalColorString = [[originalColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    NSString *destinationColorString = [[destinationColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([originalColorString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 获取RGB16进制色值
    if ([originalColorString hasPrefix:@"0X"])
        originalColorString = [originalColorString substringFromIndex:2];
    if ([originalColorString hasPrefix:@"#"])
        originalColorString = [originalColorString substringFromIndex:1];
    if ([originalColorString length] != 6)
        return [UIColor clearColor];
    
    if ([destinationColorString hasPrefix:@"0X"])
        destinationColorString = [destinationColorString substringFromIndex:2];
    if ([destinationColorString hasPrefix:@"#"])
        destinationColorString = [destinationColorString substringFromIndex:1];
    if ([destinationColorString length] != 6)
        return [UIColor clearColor];
    
    // 将16进制色值转换为十进制
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *originalRString = [originalColorString substringWithRange:range];
    NSString *destinationRString = [destinationColorString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *originalGString = [originalColorString substringWithRange:range];
    NSString *destinationGString = [destinationColorString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *originalBString = [originalColorString substringWithRange:range];
    NSString *destinationBString = [destinationColorString substringWithRange:range];
    
    unsigned int originalr, originalg, originalb;
    [[NSScanner scannerWithString:originalRString] scanHexInt:&originalr];
    [[NSScanner scannerWithString:originalGString] scanHexInt:&originalg];
    [[NSScanner scannerWithString:originalBString] scanHexInt:&originalb];
    unsigned int destinationr, destinationg, destinationb;
    [[NSScanner scannerWithString:destinationRString] scanHexInt:&destinationr];
    [[NSScanner scannerWithString:destinationGString] scanHexInt:&destinationg];
    [[NSScanner scannerWithString:destinationBString] scanHexInt:&destinationb];
    
    int diffR = destinationr - originalr;
    int diffG = destinationg - originalg;
    int diffB = destinationb - originalb;
    
    return [UIColor colorWithRed:(originalr + diffR * ratio)/255.0 green:(originalg + diffG * ratio)/255.0 blue:(originalb + diffB * ratio)/255.0 alpha:1.0];
}

@end
