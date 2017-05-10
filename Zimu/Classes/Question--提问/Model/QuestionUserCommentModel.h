//
//  QuestionUserCommentModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserCommentModel :NSObject
@property (nonatomic , copy) NSString              * userImg;               //用户头像
@property (nonatomic , copy) NSString              * commentVal;            //评论内容
@property (nonatomic , assign) NSInteger              dianZanNum;           //点赞数
@property (nonatomic , copy) NSString              * commentId;             //评论ID
@property (nonatomic , copy) NSString              * userId;                //用户ID
@property (nonatomic , copy) NSString              * userName;              //用户名

@end

@interface QuestionUserCommentModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<UserCommentModel *>              * items;

@end
