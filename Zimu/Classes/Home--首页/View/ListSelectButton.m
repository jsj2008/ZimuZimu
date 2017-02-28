//
//  ListSelectButton.m
//  Zimu
//
//  Created by Redpower on 2017/2/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListSelectButton.h"

/*标题文字常态颜色*/
#define itemTextColor [UIColor blackColor]
/*标题文字选中颜色*/
#define itemTextSelectedColor [UIColor greenColor]
/*标题背景色*/
#define itemBackgroundColor [UIColor whiteColor]
/*标题文字大小*/
#define itemTextFontSize (14)

/*动画时间*/
#define KAnimationTime (0.3f)

/*title和image的间隙*/
#define KTapping (2)


@implementation ListSelectButton


- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action{
    self = [super initWithFrame:frame];
    if (self) {
        [self MWJTabControlItemWithTitle:title imageName:imageName target:target action:action];
    }
    return self;
}

- (void)MWJTabControlItemWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action{
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:itemTextColor forState:UIControlStateNormal];
    [self setTitleColor:itemTextSelectedColor forState:UIControlStateSelected];
    [self setBackgroundColor:itemBackgroundColor];
    self.titleLabel.font = [UIFont systemFontOfSize:itemTextFontSize];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
}


/*文字和图片的左右关系*/
- (void)setZMImageSite:(ZMImageSite)ZMImageSite{
    switch (ZMImageSite) {
        case ZMImageSiteRight:
            
            [self fitImageSiteWithTitle];
            
            break;
            
        default:
            break;
    }
}

/*调整图片、文字位置*/
- (void)fitImageSiteWithTitle{
    //左边文字，右边图片
    CGFloat titleWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    CGFloat titleHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    CGFloat titleTapping = (self.frame.size.height - titleHeight)/2.0;
    CGFloat imageTapping = (self.frame.size.height - imageHeight)/2.0;
    
    if (titleWidth + imageWidth + KTapping*2 >= self.frame.size.width) {
        titleWidth = self.frame.size.width - imageWidth - KTapping*2;
        [self setImageEdgeInsets:UIEdgeInsetsMake(imageTapping, titleWidth + KTapping, imageTapping, -titleWidth + 5)];//5为微调数值
        [self setTitleEdgeInsets:UIEdgeInsetsMake(titleTapping, -imageWidth - KTapping, titleTapping, imageWidth + KTapping)];
    }else{
        [self setTitleEdgeInsets:UIEdgeInsetsMake(titleTapping, -imageWidth - KTapping, titleTapping, imageWidth + KTapping)];
        [self setImageEdgeInsets:UIEdgeInsetsMake(imageTapping, titleWidth + KTapping, imageTapping, -titleWidth - KTapping)];
    }
    
}

#pragma mark -
//旋转图片动画
- (void)rotateControlItemImage{
    [UIView animateWithDuration:KAnimationTime animations:^{
        CGAffineTransform transform = self.imageView.transform;
        transform = CGAffineTransformRotate(transform, M_PI);
        self.imageView.transform = transform;
    } completion:^(BOOL finished) {
        
    }];
}



@end
