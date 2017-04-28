//
//  VideoListCell.h
//  Zimu
//
//  Created by apple on 2017/2/28.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoListCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *detail;

@end
