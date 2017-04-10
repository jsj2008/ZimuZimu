//
//  CourseFuncationCell.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/3/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseFuncationCell.h"
#import "VideoCourseViewController.h"
#import "BookCourseViewController.h"
#import "FMListViewController.h"
#import "UIView+ViewController.h"

@implementation CourseFuncationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)videoBtnAction:(id)sender {
    NSLog(@"视频课程");
    [self.viewController.navigationController pushViewController:[[VideoCourseViewController alloc]init] animated:YES];

}
- (IBAction)bookBtnAction:(id)sender {
    NSLog(@"书籍");
    
    [self.viewController.navigationController pushViewController:[[BookCourseViewController alloc]init] animated:YES];
    
}
- (IBAction)FMBtnAction:(id)sender {
    NSLog(@"FM课程");
    [self.viewController.navigationController pushViewController:[[FMListViewController alloc]init] animated:YES];

}

@end
