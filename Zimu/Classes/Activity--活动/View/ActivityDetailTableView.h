//
//  ActivityDetailTableView.h
//  Zimu
//
//  Created by Redpower on 2017/5/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCategoryInfoModel.h"
#import "ActivityCourseModel.h"

@protocol ActivityDetailTableViewDelegate <NSObject>

- (void)activityDetailTableViewDidSelect;

@end

@interface ActivityDetailTableView : UITableView


@property (nonatomic, assign) BOOL isSelectAddress;         //是否已选择活动地址

@property (nonatomic, copy) NSString *addressString;        //活动地址名称
@property (nonatomic, strong) NSString *addressId;          //活动地址ID

@property (nonatomic, strong) ActivityCategoryInfoModel *activityCategoryInfoModel;
@property (nonatomic, copy) NSString *coursePrice;          //活动价格
@property (nonatomic, strong) ActivityCourseModel *activityCourseModel;

@property (nonatomic, strong) NSString *activityId;         //活动ID

@property (nonatomic, weak) id<ActivityDetailTableViewDelegate> detailDelegate;

@end
