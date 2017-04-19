//
//  VideoTeacherCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/10.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTeacherCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagString;
@property (weak, nonatomic) IBOutlet UILabel *buyCount;
@property (weak, nonatomic) IBOutlet UIButton *constrationBtn;

@end
