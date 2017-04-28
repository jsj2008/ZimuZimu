//
//  ZM_SelectSexView.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_SelectSexView.h"

@interface ZM_SelectSexView ()

@property (nonatomic, strong) UIImageView *bgImgeView;


@end

@implementation ZM_SelectSexView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}
//设置子视图
- (void)setChildViews{
    _bgImgeView = [[UIImageView alloc] initWithFrame:self.frame];
    _bgImgeView.image = [UIImage imageNamed:@"boy"];
    [self addSubview:_bgImgeView];
    
    CGFloat width = self.width / 2;
    CGFloat height = self.height / 2.5;
    for (int i = 0; i < 2; i ++) {
        UIButton *btn = [self backItemWithImageNamed:@"" frmae:CGRectMake(i * width, self.height - height - 35, width, height) title:@"" target:self action:@selector(btnAction:)];
        btn.tag = i;
        [self addSubview:btn];
    }
}
- (UIButton *)backItemWithImageNamed:(NSString *)imageName frmae:(CGRect)frame title:(NSString *)title target:(id)target action:(SEL)action
{
    //设置左边的按钮
    UIButton * btn =[[UIButton alloc]init];

    //内容向左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //内边距
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
    
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];

    //添加  监听  btn 按钮的Events :单击 然后调用 Target:self 的Action:方法
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}
- (void)btnAction:(UIButton *)btn{
    if (btn.tag == 0) {
        _bgImgeView.image = [UIImage imageNamed:@"boy"];
        self.sex = 0;
    }else{
        _bgImgeView.image = [UIImage imageNamed:@"girl"];
        self.sex = 1;
    }
}
@end
