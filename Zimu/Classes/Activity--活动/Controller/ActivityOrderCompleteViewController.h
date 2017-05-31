//
//  ActivityOrderCompleteViewController.h
//  Zimu
//
//  Created by Redpower on 2017/5/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ActivityOrderCompleteViewControllerDelegate <NSObject>

//重新支付
- (void)payAgain;

@end

@interface ActivityOrderCompleteViewController : UIViewController

@property (nonatomic, weak) id<ActivityOrderCompleteViewControllerDelegate> orderCompleteDelegate;

@property (nonatomic, strong) NSString *result;     //支付结果 (success、fail、cancel)
@property (nonatomic, strong) NSString *courseId;   //报名的活动ID
@property (nonatomic, strong) NSString *orderId;

@end
