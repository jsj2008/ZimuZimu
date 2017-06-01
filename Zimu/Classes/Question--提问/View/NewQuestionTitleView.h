//
//  NewQuestionTitleView.h
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewQuestionTitleViewDelegate <NSObject>

- (void)newQuestionTitleViewKeyboardWillShow:(CGFloat)keyboardHeight;
- (void)newQuestionTitleViewKeyboardWillhide:(CGFloat)keyboardHeight;

@end

@interface NewQuestionTitleView : UIView


@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, weak) id<NewQuestionTitleViewDelegate> delegate;


@end
