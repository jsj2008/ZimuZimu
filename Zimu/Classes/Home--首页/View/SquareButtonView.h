//
//  SquareButtonView.h
//  Zimu
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SquareButtonViewDelegate <NSObject>

/*在线咨询*/
- (void)consult;

/*预约专家*/
- (void)appoint;

@end

@interface SquareButtonView : UIView

@property (nonatomic, assign) id<SquareButtonViewDelegate> delegate;

@end
