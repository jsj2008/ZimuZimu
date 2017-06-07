//
//  FMCommentCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommentModel.h"

@interface FMCommentCellLayoutFrame : NSObject

/*提问：用户评论*/
//- (instancetype)initWithUserCommentModel:(UserCommentModel *)userCommentModel;
//@property (nonatomic, strong) UserCommentModel *userCommentModel;

/* 视频：用户评论 */
- (instancetype)initWithCommentModel:(CommentModel *)commentModel;
@property (nonatomic, strong) CommentModel *commentModel;


@property (nonatomic, assign) CGRect headImageViewFrame;
@property (nonatomic, assign) CGRect coverImageViewFrame;
@property (nonatomic, assign) CGRect nameLabelFrame;
@property (nonatomic, assign) CGRect commentLabelFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
