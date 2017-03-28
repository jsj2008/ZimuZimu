//
//  CourseListVideoCell.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseListVideoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *totalTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *viewCountBtn;
@property (weak, nonatomic) IBOutlet UILabel *courseTitle;

@property (nonatomic, strong) NSString *totalTime;
@property (nonatomic, assign) NSInteger readCount;

@end
