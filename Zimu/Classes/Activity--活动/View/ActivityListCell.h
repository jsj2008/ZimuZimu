//
//  ActivityListCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/19.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityListModel.h"

@interface ActivityListCell : UITableViewCell

@property (nonatomic, copy) NSString *titleString;
@property (nonatomic, copy) NSString *priceString;
@property (nonatomic, copy) NSString *bgImageString;

@property (nonatomic, strong) ActivityListModel *activityListModel;

@end
