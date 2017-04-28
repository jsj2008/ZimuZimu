//
//  ConfuseDetailView.h
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ConfuseDetailViewDelegate <NSObject>

- (void)keyboardWillShow:(CGFloat)keyboardHeight;
- (void)keyboardWillhide:(CGFloat)keyboardHeight;

@end

@interface ConfuseDetailView : UIView

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, copy) NSString *confuseString;
@property (nonatomic, assign) id<ConfuseDetailViewDelegate> delegate;

@end
