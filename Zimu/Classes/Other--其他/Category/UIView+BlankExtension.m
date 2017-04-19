//
//  UIView+BlankExtension.m
//  Demo
//
//  Created by Redpower on 2017/2/21.
//  Copyright © 2017年 Redpower. All rights reserved.
//

#import "UIView+BlankExtension.h"
#import <objc/runtime.h>

static const void *blankPageViewKey = &blankPageViewKey;

@implementation UIView (BlankExtension)


- (BlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, blankPageViewKey);
}

- (void)setBlankPageView:(BlankPageView *)blankPageView{
    [self willChangeValueForKey:@"blankPageViewKey"];
    objc_setAssociatedObject(self, blankPageViewKey, blankPageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"blankPageViewKey"];
}

- (void)configBlankPageView:(XMBlankPageType)blankPageViewType hasData:(BOOL)hasData hasError:(BOOL)hasError relodButtonBlock:(void (^)(id))block{
    
    if (!self.blankPageView) {
        self.blankPageView = [[BlankPageView alloc]initWithFrame:self.bounds];
    }
    [self.blankPageView configWithType:XMBlankPageTypeNoData hasData:hasData hasError:hasError relodButtonBlock:block];
    
    [self.blankPageContainerView insertSubview:self.blankPageView atIndex:0];

}

- (UIView *)blankPageContainerView{
    UIView *viewContainer = self;
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UITableView class]]) {
            viewContainer = view;
        }
    }
    return viewContainer;
}




@end
