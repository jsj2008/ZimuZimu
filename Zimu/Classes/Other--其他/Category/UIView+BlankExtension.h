//
//  UIView+BlankExtension.h
//  Demo
//
//  Created by Redpower on 2017/2/21.
//  Copyright © 2017年 Redpower. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BlankPageView.h"

@interface UIView (BlankExtension)

@property (nonatomic, strong) BlankPageView *blankPageView;

- (void)configBlankPageView:(XMBlankPageType)blankPageView hasData:(BOOL)hasData hasError:(BOOL)hasError relodButtonBlock:(void (^)(id))block;


@end
