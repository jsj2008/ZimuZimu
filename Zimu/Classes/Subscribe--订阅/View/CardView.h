//
//  CardView.h
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 11/1/14.
//  Copyright (c) 2014 Zhixuan Lai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CardView : UIView

@property (nonatomic, copy) NSString *imageString;      //图片
@property (nonatomic, copy) NSString *name;             //姓名
@property (nonatomic, copy) NSString *jobTitle;         //职称
@property (nonatomic, copy) NSString *introduce;        //简介

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSArray *tagArray;



@end
