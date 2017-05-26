//
//  QuestionTitleView.h
//  Zimu
//
//  Created by Redpower on 2017/5/26.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QuestionTitleViewDelegate <NSObject>

- (void)submitQuestion;

@end

@interface QuestionTitleView : UIView

@property (nonatomic, weak) id<QuestionTitleViewDelegate> delegate;

@property (nonatomic, strong) UITextField *textField;


@end
