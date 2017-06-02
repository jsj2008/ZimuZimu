//
//  ShareMyMsgViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/6/1.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ShareMyMsgViewController.h"
#import "ZMShareManager.h"

@interface ShareMyMsgViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;

@end

@implementation ShareMyMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分享名片";
    _detailLabel.text = @"扫描二维码加我好友~\n就可以和我一起超萌对话啦！";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)shareQQ:(id)sender {
    ZMShareManager *shareMgr = [[ZMShareManager alloc] init];
    [shareMgr shareImageToPlatformType:UMSocialPlatformType_QQ image:[self screenshotWithRect:_bgImgView.frame]];
}
- (IBAction)shareWX:(id)sender {
    ZMShareManager *shareMgr = [[ZMShareManager alloc] init];
    [shareMgr shareImageToPlatformType:UMSocialPlatformType_WechatSession image:[self screenshotWithRect:_bgImgView.frame]];
}
- (IBAction)shareTimeLine:(id)sender {
    ZMShareManager *shareMgr = [[ZMShareManager alloc] init];
    [shareMgr shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine image:[self screenshotWithRect:_bgImgView.frame]];
}

- (UIImage *)screenshotWithRect:(CGRect)rect;
{
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (context == NULL)
    {
        return nil;
    }
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, -rect.origin.x, -rect.origin.y);
    
    //[self layoutIfNeeded];
    
    if( [self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)])
    {
//        [self drawViewHierarchyInRect:self.view.bounds afterScreenUpdates:NO];
    }
    else
    {
        [self.view.layer renderInContext:context];
    }
    
    CGContextRestoreGState(context);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //    NSData *imageData = UIImageJPEGRepresentation(image, 1); // convert to jpeg
    //    image = [UIImage imageWithData:imageData scale:[UIScreen mainScreen].scale];
    
    return image;
}
@end
