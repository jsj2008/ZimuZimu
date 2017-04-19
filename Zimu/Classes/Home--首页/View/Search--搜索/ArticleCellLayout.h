//
//  ArticleCellLayout.h
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArticleCellLayout : NSObject

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect readCountFrame;
@property (nonatomic, assign) CGRect imageViewFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
