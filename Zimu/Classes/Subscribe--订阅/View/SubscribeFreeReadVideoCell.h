//
//  SubscribeFreeReadVideoCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscribeFreeReadVideoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;

@end
