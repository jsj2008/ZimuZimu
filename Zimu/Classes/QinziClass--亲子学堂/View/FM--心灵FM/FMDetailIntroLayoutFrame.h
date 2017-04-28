//
//  FMDetailIntroLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/4/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FMDetailIntroLayoutFrame : NSObject

@property (nonatomic, assign) CGRect markLabelFrame;
@property (nonatomic, assign) CGRect contentLabelFrame;
@property (nonatomic, assign) CGRect openButtonFrame;

@property (nonatomic, assign) BOOL isOpening;       //内容是否展开

@property (nonatomic, assign) CGFloat cellHeight;

@end

