//
//  ListSelectButton.m
//  Zimu
//
//  Created by Redpower on 2017/2/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ListSelectButton.h"

/*标题文字常态颜色*/
#define itemTextColor themeBlack
/*标题文字选中颜色*/
#define itemTextSelectedColor [UIColor greenColor]
/*标题背景色*/
#define itemBackgroundColor [UIColor whiteColor]
/*标题文字大小*/
#define itemTextFontSize (14)

/*动画时间*/
#define KAnimationTime (0.3f)

/*title和image的间隙*/
#define KTapping (3)


@implementation ListSelectButton

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action{
    self = [super initWithFrame:frame];
    if (self) {
        [self setItemWithTitle:title imageName:imageName target:target action:action];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName{
    self = [super initWithFrame:frame];
    if (self) {
        [self setItemWithTitle:title imageName:imageName target:nil action:nil];
    }
    return self;
}

- (void)setItemWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action{
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
    if (_ZMImageSite != ZMImageSite) {
        _ZMImageSite = ZMImageSite;
        [self fitImageSiteWithTitle];
    }
}

/*调整图片、文字位置*/
- (void)fitImageSiteWithTitle{
    //左边文字，右边图片
    CGFloat titleWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    CGFloat titleHeight = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    CGFloat titleTapping = (self.height - titleHeight)/2.0;
    CGFloat imageTapping = (self.height - imageHeight)/2.0;
    
    //判断 文字宽度+图片宽度 与 按钮宽度 的大小
    if (titleWidth + imageWidth + KTapping*2 >= self.frame.size.width) {
        //大于
        titleWidth = self.width - imageWidth - KTapping;
    }
    CGFloat x = (self.width - titleWidth - imageWidth - KTapping)/2.0;
    switch (self.ZMImageSite) {
        case ZMImageSiteRight:      //图片在右，文字在左
            
            self.titleRect = CGRectMake(x, titleTapping, titleWidth, titleHeight);
            self.imageRect = CGRectMake(x + titleWidth + KTapping, imageTapping, imageWidth, imageHeight);
            
            break;
            
        default:                //图片在左，文字在右
            
            self.imageRect = CGRectMake(x, imageTapping, imageWidth, imageHeight);
            self.titleRect = CGRectMake(x + imageWidth + KTapping, titleTapping, titleWidth, titleHeight);
            
            break;
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


#pragma mark - 重写设置图片、标题frame方法
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.titleRect) && !CGRectEqualToRect(self.titleRect, CGRectZero)) {
        return self.titleRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (!CGRectIsEmpty(self.imageRect) && !CGRectEqualToRect(self.imageRect, CGRectZero)) {
        return self.imageRect;
    }
    return [super titleRectForContentRect:contentRect];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    
    //标题改变时，重新计算frame
    [self fitImageSiteWithTitle];
}


@end
