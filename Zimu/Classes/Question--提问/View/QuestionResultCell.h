//
//  QuestionResultCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/20.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchQuestionModel.h"

@interface QuestionResultCell : UITableViewCell


@property (nonatomic, copy) NSString *titleString;

@property (nonatomic, strong) SearchQuestionResultModel *model;



@end
