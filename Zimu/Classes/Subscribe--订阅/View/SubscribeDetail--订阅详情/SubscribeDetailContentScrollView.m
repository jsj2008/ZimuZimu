//
//  SubscribeDetailContentScrollView.m
//  Zimu
//
//  Created by Redpower on 2017/3/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeDetailContentScrollView.h"


static NSInteger headViewHeight = 200;

@implementation SubscribeDetailContentScrollView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){

    }
    return self;
}

- (void)setOffset:(CGPoint)offset{
    _offset = offset;
//    NSLog(@"%@", NSStringFromCGPoint(offset));
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    
    UIView* view = [super hitTest:point withEvent:event];
    BOOL hitHead = point.y < (headViewHeight - self.offset.y);
    if (hitHead || !view){
//        NSLog(@"no view");
        self.scrollEnabled = NO;
        if (!view){
            for (UIView* subView in self.subviews) {
                if (subView.frame.origin.x == self.contentOffset.x){
                    view = subView;
                }
            }
        }
        return view;
    } else{
//        NSLog(@"view = %@", view);
        self.scrollEnabled = YES;
        return view;
        
    }
}

@end
