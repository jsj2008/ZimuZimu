//
//  CallPhoneView.h
//  Zimu
//
//  Created by Redpower on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CallPhoneViewDelegate;

@interface CallPhoneView : UIView

@property (nonatomic, copy) NSString *phoneString;      //电话号码
@property (nonatomic, assign) id<CallPhoneViewDelegate> delegate;

@end

@protocol CallPhoneViewDelegate <NSObject>
@optional
//点击取消
- (void)callPhoneViewDidClickClose;

@end
