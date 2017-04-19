//
//  CircleView.h
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleView : UIView


@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign) CGFloat strokeStart;
@property (nonatomic, strong) CAShapeLayer *progressLayer;


- (void)drawCircle;

@end
