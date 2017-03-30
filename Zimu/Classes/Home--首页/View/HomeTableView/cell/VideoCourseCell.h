//
//  VideoCourseCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/8.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef enum VideoCourseCellStyle{
//    VideoCourseCellStyleFree = 0,           //免费课程
//    VideoCourseCellStyleNotFree = 1,        //付费课程
//}VideoCourseCellStyle;

@interface VideoCourseCell : UITableViewCell

//@property (nonatomic, assign) VideoCourseCellStyle videoCourseCellStyle;
@property (nonatomic, strong) NSArray *homeFreeCourseModelArray;
@property (nonatomic, strong) NSArray *homeNotFreeCourseModelArray;

@end
