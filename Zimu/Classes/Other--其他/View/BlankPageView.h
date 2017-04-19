//
//  BlankPageView.h
//  Demo
//
//  Created by Redpower on 2017/2/21.
//  Copyright © 2017年 Redpower. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum XMBlankPageType{
    XMBlankPageTypeNoData = 0,
    XMBlankPageTypeError = 1,
}XMBlankPageType;

@interface BlankPageView : UIView

@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, copy) void (^reloadButtonBlock)(id sender);

- (void)configWithType:(XMBlankPageType)XMBlankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError relodButtonBlock:(void (^)(id))block;


@end
