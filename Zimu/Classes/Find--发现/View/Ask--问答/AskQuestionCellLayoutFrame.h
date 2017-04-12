//
//  AskQuestionCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/4/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AskQuestionCellLayoutFrame : NSObject

@property (nonatomic, assign) CGRect headImageViewFrame;
@property (nonatomic, assign) CGRect nameLabelFrame;
@property (nonatomic, assign) CGRect timeLabelFrame;
@property (nonatomic, assign) CGRect moreButtonFrame;
@property (nonatomic, assign) CGRect seperateLineFrame;
@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect contentLabelFrame;
@property (nonatomic, assign) CGRect likeButtonFrame;
@property (nonatomic, assign) CGRect commentLabelFrame;
@property (nonatomic, assign) CGRect enterButtonFrame;

@property (nonatomic, assign) CGFloat cellHeight;

- (instancetype)initWithContent:(NSString *)content;

@property (nonatomic, copy) NSString *content;


@end


