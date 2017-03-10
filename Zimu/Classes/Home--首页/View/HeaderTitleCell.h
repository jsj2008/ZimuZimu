//
//  HeaderTitleCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *moreButton;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (nonatomic, copy) NSString *titleString;

@end
