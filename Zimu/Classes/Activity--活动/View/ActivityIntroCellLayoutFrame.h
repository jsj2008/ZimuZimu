//
//  ActivityIntroCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/5/9.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityIntroCellLayoutFrame : NSObject

@property (nonatomic, assign) CGRect markLabelFrame;
@property (nonatomic, assign) CGRect separateLineFrame;
@property (nonatomic, assign) CGRect introLabelFrame;
@property (nonatomic, assign) CGRect lookMoreButtonFrame;

@property (nonatomic, assign) BOOL isOpening;       //内容是否展开

@property (nonatomic, assign) CGFloat cellHeight;

@end
