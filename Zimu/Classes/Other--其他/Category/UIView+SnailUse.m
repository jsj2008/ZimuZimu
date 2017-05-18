//
//  UIView+SnailUse.m
//  Zimu
//
//  Created by Redpower on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "UIView+SnailUse.h"
#import "PaymentChannelView.h"
#import "CallPhoneView.h"
#import "ZM_SelectSexView.h"
<<<<<<< HEAD
#import "CommentBar.h"
=======
#import "AgeRangeView.h"
>>>>>>> origin/master

@implementation UIView (SnailUse)

+ (id)paymentChannelView{
    PaymentChannelView *view = [[PaymentChannelView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    
    return view;
}

+ (id)callPhoneView{
    CallPhoneView *view = [[CallPhoneView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 153)];
    
    return view;
}
+ (id)sexChooseView{
    ZM_SelectSexView *view = [[ZM_SelectSexView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 80, kScreenHeight - 290)];
    view.sex = 0;
    return view;
}

<<<<<<< HEAD
+ (id)commentBar{
    CommentBar *commentBar = [[CommentBar alloc]initWithFrame:CGRectMake(0, kScreenHeight - 49 - 64, kScreenWidth, 49) containNaviHeight:YES];
    return commentBar;
=======
+ (id)ageChooseView{
    AgeRangeView *view = [[AgeRangeView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180) style:UITableViewStylePlain];
    return view;
>>>>>>> origin/master
}

@end
