//
//  EditSexTableViewController.h
//  Zimu
//
//  Created by Redpower on 2017/5/2.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SexBlock)(NSString *);

@interface EditSexTableViewController : UITableViewController

@property (nonatomic, copy) SexBlock sexBlock;

@property (nonatomic, copy) NSString *sex;


@end
