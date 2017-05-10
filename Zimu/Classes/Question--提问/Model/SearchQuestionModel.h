//
//  SearchQuestionModel.h
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchQuestionResultModel :NSObject
@property (nonatomic , copy) NSString              * questionId;               //问题id
@property (nonatomic , copy) NSString              * questionTitle;            //问题标题
@property (nonatomic , copy) NSString              * isExpAnswer;              //是否专家已解答 0：未解答  1：已解答
@property (nonatomic , copy) NSString              * commentNum;

@end

@interface SearchQuestionModel :NSObject
@property (nonatomic , assign) BOOL              isTrue;
@property (nonatomic , copy) NSString              * message;
@property (nonatomic , strong) NSArray<SearchQuestionResultModel *>              * items;

@end
