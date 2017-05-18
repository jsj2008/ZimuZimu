//
//  ZMShareManager.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZMShareManager.h"

@implementation ZMShareManager

- (instancetype)init{
    self = [super init];
    if (self) {
        
//        /* 设置微信的appKey和appSecret */
//        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxf3b92b17e0cdf08b" appSecret:@"78dde879ce172c645034a5da011921ca" redirectURL:@"http://mobile.umeng.com/social"];
//        /*
//         * 设置微信朋友圈
//         */
//        //     [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxf3b92b17e0cdf08b" appSecret:@"78dde879ce172c645034a5da011921ca" redirectURL:@"http://mobile.umeng.com/social"];
//        //[[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];
//        
//        /* 设置分享到QQ互联的appID
//         * U-Share SDK为了兼容大部分平台命名，统一用appKey和appSecret进行参数设置，而QQ平台仅需将appID作为U-Share的appKey参数传进即可。
//         100424468.no permission of union id
//         */
//        [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"1105934837"/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    }
    return self;
}

#pragma mark - 分享图片
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType image:(UIImage *)img{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图本地
    shareObject.thumbImage = [UIImage imageNamed:@"icon"];
    
    [shareObject setShareImage:img];
    
    // 设置Pinterest参数
//    if (platformType == UMSocialPlatformType_Pinterest) {
//        [self setPinterstInfo:messageObject];
//    }
    
//    // 设置Kakao参数
//    if (platformType == UMSocialPlatformType_KakaoTalk) {
//        messageObject.moreInfo = @{@"permission" : @1}; // @1 = KOStoryPermissionPublic
//    }
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    //调用分享接口
    UIViewController *VC = [ZMShareManager curTopViewController];
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:VC completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
//视频分享
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType Title:(NSString *)title descr:(NSString *)descr thumImage:(NSString *)thumbURL
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
//    NSString* thumbURL =  thumbURL;
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:descr thumImage:thumbURL];
    //设置视频网页播放地址
    shareObject.videoUrl = thumbURL;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    UIViewController *VC = [ZMShareManager curTopViewController];
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:VC completion:^(id data, NSError *error) {

        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
//网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType thumbImg:(id)thumbImg webLink:(NSString *)webLink title:(NSString *)title descr:(NSString *)descr
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象 预览图
    NSString* thumbURL =  thumbImg;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = webLink;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
        //调用分享接口
    UIViewController *VC = [ZMShareManager curTopViewController];
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:VC completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
- (void)shareLocalVedioToPlatformType:(UMSocialPlatformType)platformType Title:(NSString *)title descr:(NSString *)descr thumImage:(NSString *)thumbURL
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
//    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:descr thumImage:thumbURL];
    //设置视频网页播放地址
    shareObject.videoStreamUrl = thumbURL;
    shareObject.videoUrl = @"http://video.sina.com.cn/p/sports/cba/v/2013-10-22/144463050817.html";
//
//    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:thumbURL withExtension:@"mp4"];
//    NSData* videoData = [[NSData alloc] initWithContentsOfURL:bundleURL];
//    shareObject.videoData = videoData;
//    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    UIViewController *VC = [ZMShareManager curTopViewController];
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:VC completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
        [self alertWithError:error];
    }];
}
#pragma mark - 共用方法
 - (void)alertWithError:(NSError *)error
{
    NSString *result = nil;
    if (!error) {
        result = [NSString stringWithFormat:@"Share succeed"];
    }
    else{
        NSMutableString *str = [NSMutableString string];
        if (error.userInfo) {
            for (NSString *key in error.userInfo) {
                [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
            }
        }
        if (error) {
            result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
        }
        else{
            result = [NSString stringWithFormat:@"Share fail"];
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                    message:result
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"sure", @"确定")
                                          otherButtonTitles:nil];
    [alert show];
}
 
 - (void)setPinterstInfo:(UMSocialMessageObject *)messageObj
{
    messageObj.moreInfo = @{@"source_url": @"http://www.umeng.com",
                            @"app_name": @"U-Share",
                            @"suggested_board_name": @"UShareProduce",
                            @"description": @"U-Share: best social bridge"};
}
 
 
 - (UIImage *)resizeImage:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, UIScreen.mainScreen.scale);
    CGRect imageRect = CGRectMake(0.0, 0.0, size.width, size.height);
    [image drawInRect:imageRect];
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retImage;
}
//获取当前显示的VC
+ (UIViewController*)curTopViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return [self topViewControllerWithRootViewController:window.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController1 = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController1.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
@end
