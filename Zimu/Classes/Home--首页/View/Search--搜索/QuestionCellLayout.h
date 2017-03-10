//
//  QuestionCellLayout.h
//  Zimu
//
//  Created by Redpower on 2017/3/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionCellLayout : NSObject

@property (nonatomic, assign) CGRect titleFrame;
@property (nonatomic, assign) CGRect contentFrame;
@property (nonatomic, assign) CGRect readCountFrame;
@property (nonatomic, assign) CGRect replyCountFrame;
@property (nonatomic, assign) CGRect reviewFrame;

@property (nonatomic, assign) CGFloat cellHeight;

@end
