//
//  PreviewPhotoVideoViewController.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/25.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PreviewPhotoVideoDelegate <NSObject>

- (void)gotoShareImg:(UIImage *)img;

@end
@interface PreviewPhotoVideoViewController : UIViewController

@property (nonatomic, weak) id<PreviewPhotoVideoDelegate> previewDelegate;
/*  用要预览的图片初始化*/
- (instancetype)initWithPhoto:(UIImage *)image;
/*用视频路径初始化*/
- (instancetype)initWithVideoPath:(NSString *)path;

@end
