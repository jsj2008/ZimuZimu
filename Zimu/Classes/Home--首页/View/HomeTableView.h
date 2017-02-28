//
//  HomeTableView.h
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeArrayDataSource.h"

@interface HomeTableView : UITableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style homeArrayDataSource:(HomeArrayDataSource *)homeArrayDataSource;

@end

