//
//  ListSelectButton.h
//  Zimu
//
//  Created by Redpower on 2017/2/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum ZMImageSite{
    ZMImageSiteLeft = 0,        //文字在右，图片在左
    ZMImageSiteRight = 1,       //文字在左，图片在右
}ZMImageSite;

@interface ListSelectButton : UIButton

@property (nonatomic, assign) ZMImageSite ZMImageSite;

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageName:(NSString *)imageName target:(id)target action:(SEL)action;



//旋转图片
- (void)rotateControlItemImage;


@end
