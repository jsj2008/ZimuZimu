//
//  ZM_BigBtn.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZM_BigBtn : UIView

//需要显示的图片和标题
@property (nonatomic, strong) NSString *imgName;
@property (nonatomic, strong) NSString *nameString;

@property (nonatomic, assign) BOOL isSelected;

- (instancetype)initWithImgName:(NSString *)imgName titleString:(NSString *)titleString frame:(CGRect) rect;

@end
