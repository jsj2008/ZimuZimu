//
//  RecommendQuestionLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/6/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RecommendQuestionModel.h"

@interface RecommendQuestionLayoutFrame : NSObject

- (instancetype)initWithModel:(RecommendQuestionModel *)model;

@property (nonatomic, strong) RecommendQuestionModel *model;

@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect contentLabelFrame;
@property (nonatomic, assign) CGRect answerLabelFrame;
@property (nonatomic, assign) CGRect countLabelFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
