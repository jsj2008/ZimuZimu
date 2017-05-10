//
//  QuestionExpertAnswerModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExpertAnswerModel :NSObject
@property (nonatomic , copy) NSString              * userId;                //专家ID
@property (nonatomic , copy) NSString              * userName;              //专家姓名
@property (nonatomic , copy) NSString              * userImg;               //专家头像
@property (nonatomic , copy) NSString              * good;                  //擅长：标签
@property (nonatomic , copy) NSString              * commentVal;            //评论内容
@property (nonatomic , copy) NSString              * commentId;             //评论ID
@property (nonatomic , assign) NSInteger              dianZanNum;
@property (nonatomic , assign) NSInteger              commentNum;

@end

@interface QuestionExpertAnswerModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<ExpertAnswerModel *>              * items;

@end
