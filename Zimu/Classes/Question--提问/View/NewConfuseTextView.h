//
//  NewConfuseTextView.h
//  Zimu
//
//  Created by Redpower on 2017/5/31.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewConfuseTextViewDelegate <NSObject>

- (void)newConfuseTextViewKeyboardWillShow:(CGFloat)keyboardHeight;
- (void)newConfuseTextViewKeyboardWillhide:(CGFloat)keyboardHeight;

@end

@interface NewConfuseTextView : UIView

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, copy) NSString *confuseString;
@property (nonatomic, weak) id<NewConfuseTextViewDelegate> delegate;


@end
