//
//  FindTestListCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/5.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindTestListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *countCount;

@property (nonatomic, assign) NSInteger count;
@end
