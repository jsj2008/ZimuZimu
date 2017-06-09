//
//  RecommendQuestionModel.h
//  Zimu
//
//  Created by Redpower on 2017/6/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendQuestionModel :NSObject

@property (nonatomic , copy) NSString              * questionId;            //问题ID
@property (nonatomic , copy) NSString              * questionTitle;         //问题标题
@property (nonatomic , copy) NSString              * isExpAnswer;           //专家是否已解答
@property (nonatomic , copy) NSString              * commentNum;            //评论数
@property (nonatomic , copy) NSString              * questionVal;           //问题内容

@end

