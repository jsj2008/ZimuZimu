//
//  CommentBar.h
//  Zimu
//
//  Created by Redpower on 2017/5/15.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommentBarDelegate <NSObject>

@optional
/*分享*/
- (void)commentBarShare;
/*收藏*/
- (void)commentBarSelect;
/*点击评论按钮*/
- (void)commentBarComment;
/*发表评论*/
- (void)commentBarSubmit:(NSString *)text;

@end

@interface CommentBar : UIView

@property (nonatomic, strong) UITextField *textField;

- (instancetype)initWithFrame:(CGRect)frame containNaviHeight:(BOOL)containNaviHeight;

@property (nonatomic, assign) id<CommentBarDelegate> delegate;

@end
