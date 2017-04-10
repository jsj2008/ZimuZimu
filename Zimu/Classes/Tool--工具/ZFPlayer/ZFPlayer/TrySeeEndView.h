//
//  TrySeeEndView.h
//  Zimu
//
//  Created by apple on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrySeeEndView;
static TrySeeEndView *_instance = nil;

@interface TrySeeEndView : UIView

@property (weak, nonatomic) IBOutlet UIButton *goBuyBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgV;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, assign) CGFloat trySeePrice;

+ (TrySeeEndView *)shareInstance;

@end
