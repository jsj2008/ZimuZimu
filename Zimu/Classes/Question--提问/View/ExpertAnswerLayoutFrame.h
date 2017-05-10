//
//  ExpertAnswerLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionExpertAnswerModel.h"

@interface ExpertAnswerLayoutFrame : NSObject

- (instancetype)initWithExpertAnswerModel:(ExpertAnswerModel *)expertAnswerModel;
@property (nonatomic, strong) ExpertAnswerModel *expertAnswerModel;

@property (nonatomic, assign) CGRect headImageViewFrame;
@property (nonatomic, assign) CGRect headCoverImageViewFrame;
@property (nonatomic, assign) CGRect nameLabelFrame;
@property (nonatomic, assign) CGRect tagLabel1Frame;
@property (nonatomic, assign) CGRect tagLabel2Frame;
@property (nonatomic, assign) CGRect advisoryButtonFrame;
@property (nonatomic, assign) CGRect answerLabelFrame;
@property (nonatomic, assign) CGRect seperateLineFrame;
@property (nonatomic, assign) CGRect likeButtonFrame;
@property (nonatomic, assign) CGRect commentButtonFrame;
@property (nonatomic, assign) CGRect shareButtonFrame;

@property (nonatomic, assign) CGFloat cellHeight;




@end

