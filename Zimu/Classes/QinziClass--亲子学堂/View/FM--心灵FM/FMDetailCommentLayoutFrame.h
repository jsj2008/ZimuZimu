//
//  FMDetailCommentLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/4/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionUserCommentModel.h"

@interface FMDetailCommentLayoutFrame : NSObject


/*提问：用户评论*/
- (instancetype)initWithUserCommentModel:(UserCommentModel *)userCommentModel;
@property (nonatomic, strong) UserCommentModel *userCommentModel;


@property (nonatomic, assign) CGRect headImageViewFrame;
@property (nonatomic, assign) CGRect nameLabelFrame;
@property (nonatomic, assign) CGRect likeButtonFrame;
@property (nonatomic, assign) CGRect commentLabelFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
