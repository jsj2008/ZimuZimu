//
//  ActivityHeaderCell.h
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCategoryInfoModel.h"

@interface ActivityHeaderCell : UITableViewCell

@property (nonatomic, strong) ActivityCategoryInfoModel *activityCategoryInfoModel;
@property (nonatomic, copy) NSString *coursePrice;

@end
