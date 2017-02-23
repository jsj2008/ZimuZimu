//
//  UIImage+ZMExtension.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "UIImage+ZMExtension.h"

@implementation UIImage (ZMExtension)

+ (UIImage *)originalImageWithImageName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}

@end
