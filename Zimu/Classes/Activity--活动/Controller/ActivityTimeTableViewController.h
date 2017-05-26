//
//  ActivityTimeTableViewController.h
//  Zimu
//
//  Created by Redpower on 2017/5/18.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol ActivityTimeTableViewControllerDelegate <NSObject>

- (void)activityTimeTableViewControllerDidSelectAddress:(NSString *)address courseId:(NSString *)courseId;

@end

@interface ActivityTimeTableViewController : UITableViewController

@property (nonatomic, copy) NSString *categoryId;

@property (nonatomic, weak) id<ActivityTimeTableViewControllerDelegate> delegate;

@end
