//
//  ActivityOrderFailView.h
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityOrderFailViewDelegate <NSObject>

//退出返回
- (void)activityOrderFailViewQuit;

//重新支付
- (void)activityOrderFailViewPayAgain;

@end

@interface ActivityOrderFailView : UIView

@property (nonatomic, weak) id<ActivityOrderFailViewDelegate> delegate;

@end
