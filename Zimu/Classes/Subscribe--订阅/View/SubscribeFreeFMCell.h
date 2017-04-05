//
//  SubscribeFreeFMCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/29.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubscribeFreeFMCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *fmTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *updateTimeLable;
@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *listenCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodCountLabel;

@end
