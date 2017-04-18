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

+ (UIColor *)mostColorOfImage:(UIImage *)image{
    
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize = CGSizeMake(50, 50);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x = 0; x < thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4 * (x * y);
            
            int red = data[offset];
            int green = data[offset + 1];
            int blue = data[offset + 2];
            int alpha =  data[offset + 3];
            
            NSArray *clr = @[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
            
        }
    }
    CGContextRelease(context);
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor = nil;
    NSUInteger MaxCount = 0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}

@end
