//
//  MySecretCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SecretModel.h"

@interface MySecretCellLayoutFrame : NSObject

- (instancetype)initWithSecretModel:(SecretModel *)secretModel;
@property (nonatomic, strong) SecretModel *secretModel;

@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect timeLabelFrame;
@property (nonatomic, assign) CGRect seperateLineFrame;
@property (nonatomic, assign) CGRect contentLabelFrame;
@property (nonatomic, assign) CGRect likeButtonFrame;
@property (nonatomic, assign) CGRect commentButtonFrame;
@property (nonatomic, assign) CGRect answerStateButtonFrame;
@property (nonatomic, assign) CGRect moreImageViewFrame;

@property (nonatomic, assign) CGFloat cellHeight;


@end



