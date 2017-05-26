//
//  ActivityOrderSuccessView.h
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OfflineCourseModel.h"

@protocol ActivityOrderSuccessViewDelegate <NSObject>

//退出返回
- (void)activityOrderSuccessViewQuit;

//查看订单
- (void)activityOrderSuccessViewCheckOrder;

@end

@interface ActivityOrderSuccessView : UIView

@property (nonatomic, weak) id<ActivityOrderSuccessViewDelegate> delegate;

@property (nonatomic, strong) OfflineCourseModel *offlineCourseModel;


@end
