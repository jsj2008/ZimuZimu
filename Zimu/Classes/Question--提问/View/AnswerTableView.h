//
//  AnswerTableView.h
//  Zimu
//
//  Created by Redpower on 2017/4/21.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionDetailModel.h"

@interface AnswerTableView : UITableView

@property (nonatomic, strong) QuestionModel *questionModel;
@property (nonatomic, strong) NSArray *resultArray;

@property (nonatomic, assign) NSInteger careState;      //用户是否已关注该问题

@end
