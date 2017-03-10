//
//  SquareButtonView.h
//  Zimu
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SquareButtonViewDelegate <NSObject>

/*考试报名*/
- (void)examApply;

/*试题解答*/
- (void)questionAnswer;

/*公开课程*/
- (void)openCourse;

/*公益众筹*/
- (void)publicBenefit;

@end

@interface SquareButtonView : UIView

@property (nonatomic, assign) id<SquareButtonViewDelegate> delegate;

@end
