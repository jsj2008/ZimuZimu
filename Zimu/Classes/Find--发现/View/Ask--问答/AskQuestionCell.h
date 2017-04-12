//
//  AskQuestionCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/11.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AskQuestionCellLayoutFrame.h"

@interface AskQuestionCell : UITableViewCell

@property (nonatomic, strong) AskQuestionCellLayoutFrame* layoutFrame;

@property (nonatomic, copy) NSString *content;

@end
