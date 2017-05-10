//
//  ConfuseContentCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionDetailModel.h"

@interface ConfuseContentCellLayoutFrame : NSObject

- (instancetype)initWithModel:(QuestionModel *)model;

@property (nonatomic, strong) QuestionModel *model;

@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect contentLabelFrame;

@property (nonatomic, assign) CGRect seperateLineFrame;
@property (nonatomic, assign) CGRect likeButtonFrame;
@property (nonatomic, assign) CGRect commentButtonFrame;
@property (nonatomic, assign) CGRect shareButtonFrame;

@property (nonatomic, assign) CGFloat cellHeight;


@end
