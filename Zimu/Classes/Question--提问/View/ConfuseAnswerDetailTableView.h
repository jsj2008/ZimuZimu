//
//  ConfuseAnswerDetailTableView.h
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionDetailModel.h"

@interface ConfuseAnswerDetailTableView : UITableView

@property (nonatomic, strong) QuestionModel *questionModel;
@property (nonatomic, strong) NSArray *expertAnswerModelArray;
@property (nonatomic, strong) NSArray *userCommentModelArray;

@end
