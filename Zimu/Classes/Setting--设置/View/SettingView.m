//
//  SettingView.m
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SettingView.h"
#import "DeviceMessageModel.h"

@interface SettingView (){
    NSArray *titles;
}

@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation SettingView

+ (instancetype)showToView:(UIView *)view{
    SettingView *settingView = [[self alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    [view addSubview:settingView];
    [settingView animation];
    
    return settingView;
}

- (void)animation{
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform, 0.6, 0.6);
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

- (instancetype)initWithEffect:(UIVisualEffect *)effect{
    self = [super initWithEffect:effect];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        titles = @[@"清理缓存", @"意见反馈",@"使用帮助",@"评价我们",@"关于子慕"];
        
        
        /*添加返回按钮*/
        [self setBackButton];
        /*按钮*/
        [self setupButtons];
        /*APPIcon*/
        [self setupAppIcon];
        /*APP版本*/
        [self setupVersionLabel];
        
    }
    return self;
}

/**
 *  返回按钮
 */
- (void)setBackButton{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 80, 80);
    [button setImage:[UIImage imageNamed:@"setting_back"] forState:UIControlStateNormal];
    [button setImageEdgeInsets:UIEdgeInsetsMake(40, 20, 20, 40)];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
- (void)back{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformScale(self.transform, 0.6, 0.6);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

/**
 *  APP图标
 */
- (void)setupAppIcon{
    CGFloat width = 80 * kScreenWidth / 375.0;
    _iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, width, width)];
    UIView *view = [self viewWithTag:110];
    CGFloat gap = 40 * kScreenWidth/375.0;
    _iconImageView.center = CGPointMake(self.centerX, view.y - gap - width/2.0);
    _iconImageView.image = [UIImage imageNamed:@"App_icon"];
    [self addSubview:_iconImageView];
}


/**
 *  创建按钮
 */
- (void)setupButtons{
    CGFloat height = 45 * kScreenWidth / 375.0;
    CGFloat y = CGRectGetMaxY(_iconImageView.frame) + 30;
    UIFont *font = [UIFont systemFontOfSize:16];
    if (kScreenWidth > 320) {
//        height = 50;
        y = CGRectGetMaxY(_iconImageView.frame) + 80;
        font = [UIFont systemFontOfSize:20];
    }
    for (int index = 0; index < titles.count; index++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        NSString *title = titles[index];
        button.titleLabel.font = font;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:themeBlack forState:UIControlStateNormal];
        CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font}];
        button.width = size.width + 18;
        button.height = height;
        
        //第二个按钮center等于self的center
        if (index == 0) button.center = CGPointMake(self.center.x, self.center.y - button.height);
        else if (index == 1) button.center = self.center;
        else button.center = CGPointMake(self.center.x, self.center.y + button.height * (index - 1));
//        button.y = y + height * index;
//        button.x = kScreenWidth/2.0 - button.width/2.0;
        
        button.tag = 110 + index;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }
}
- (void)buttonAction:(UIButton *)button{
    NSInteger index = button.tag - 110;
    switch (index) {
        case 0:{                    //清理缓存
            
        }
            
            break;
            
        case 1:{                    //意见反馈
            
        }
            
            break;
            
        case 2:{                    //使用帮助
            
        }
            
            break;
            
        case 3:{                    //评价我们
            
        }
            
            break;
            
        case 4:{                    //关于子慕
            
        }
            
            break;
    }
    NSLog(@"%@",button.titleLabel.text);
}

/**
 *  APP版本
 */
- (void)setupVersionLabel{
    UILabel *versionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.height - 50 - 20, self.width, 20)];
    versionLabel.font = [UIFont boldSystemFontOfSize:15];
    versionLabel.textColor = [UIColor colorWithHexString:@"999999"];
    versionLabel.text = [NSString stringWithFormat:@"Version %@", [DeviceMessageModel GetAPPVersion]];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:versionLabel];
}



@end
