//
//  FMTableView.h
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDetailModel.h"
#import "ExpertDetailModel.h"

@interface FMTableView : UITableView

@property (nonatomic, strong) FMDetailModel *fmDetailModel;
@property (nonatomic, strong) ExpertDetailModel *expertDetailModel;
@property (nonatomic, strong) NSArray *fmCommentModelArray;

@end
