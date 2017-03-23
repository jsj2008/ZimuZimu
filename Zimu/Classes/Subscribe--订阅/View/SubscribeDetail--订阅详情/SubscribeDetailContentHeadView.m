//
//  SubscribeDetailContentHeadView.m
//  Zimu
//
//  Created by Redpower on 2017/3/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "SubscribeDetailContentHeadView.h"

@implementation SubscribeDetailContentHeadView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if ([view isKindOfClass:[UIButton class]]){
        return view;
    }
    
    return nil;
}

@end
