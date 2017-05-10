//
//  EditAgeTableViewController.h
//  Zimu
//
//  Created by Redpower on 2017/5/3.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AgeBlock)(NSString *);

@interface EditAgeTableViewController : UITableViewController

@property (nonatomic, copy) AgeBlock ageBlock;

@property (nonatomic, copy) NSString *ageString;


@end
