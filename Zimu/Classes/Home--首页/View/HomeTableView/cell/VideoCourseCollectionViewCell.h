//
//  VideoCourseCollectionViewCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeFreeCourseModel.h"
#import "HomeNotFreeCourseModel.h"

@interface VideoCourseCollectionViewCell : UICollectionViewCell



@property (nonatomic, strong) HomeFreeCourseItems *homeFreeCourseModel;
@property (nonatomic, strong) HomeNotFreeCourseItems *homeNotFreeCourseModel;

@end
