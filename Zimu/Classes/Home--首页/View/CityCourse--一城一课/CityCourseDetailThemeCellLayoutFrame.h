//
//  CityCourseDetailThemeCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/4/13.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityCourseDetailThemeCellLayoutFrame : NSObject

@property (nonatomic, copy) NSString *themeString;
@property (nonatomic, assign) CGRect themeLabelFrame;
@property (nonatomic, assign) CGFloat cellHeight;


- (instancetype)initWithThemeString:(NSString *)themeString;

@end
