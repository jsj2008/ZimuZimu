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
- (void)commentBarSelect:(UIButton *)button;
/*点击评论按钮*/
- (void)commentBarComment;
/*发表评论*/
- (void)commentBarSubmit:(NSString *)text;

@end

@interface CommentBar : UIView

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL hasCollected;        //是否已收藏
@property (nonatomic, assign) BOOL collectButtonHide;   //是否需要收藏
@property (nonatomic, assign) BOOL shareButtonHidde;    //是否需要分享

- (instancetype)initWithFrame:(CGRect)frame containNaviHeight:(BOOL)containNaviHeight;

@property (nonatomic, assign) id<CommentBarDelegate> delegate;

@end
