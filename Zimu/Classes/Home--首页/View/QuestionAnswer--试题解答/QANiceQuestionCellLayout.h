//
//  QANiceQuestionCellLayout.h
//  Zimu
//
//  Created by Redpower on 2017/3/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QANiceQuestionCellLayout : NSObject

@property (nonatomic, assign) CGRect headImageViewFrame;
@property (nonatomic, assign) CGRect nameLabelFrame;
@property (nonatomic, assign) CGRect timeLabelFrame;
@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect questionImageViewFrame;
@property (nonatomic, assign) CGRect answerLabelFrame;
@property (nonatomic, assign) CGRect separateLineFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) BOOL hasQuestionImage;
- (instancetype)initWithQuestionImage:(BOOL)hasQuestionImage;

@end
