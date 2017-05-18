//
//  ZMShareManager.h
//  Zimu
//
//  Created by 飞飞飞 on 2017/5/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

@interface ZMShareManager : NSObject
/*
 分享图片 platformType 分享到的平台
         img           分享的图片
 */
- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType image:(UIImage *)img;
/*
 分享网页 platformType 分享到的平台
 thumbImg           预览的图片
 webLink            网页链接
 title              标题
 descr              副标题
 */

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType thumbImg:(id)thumbImg webLink:(NSString *)webLink title:(NSString *)title descr:(NSString *)descr;
/*
 分享视频 platformType 分享到的平台
 thumbImg           预览的图片
 webLink            网页链接
 title              标题
 descr              副标题
 */
- (void)shareVedioToPlatformType:(UMSocialPlatformType)platformType Title:(NSString *)title descr:(NSString *)descr thumImage:(NSString *)thumbURL;

//本地视频  暂未开通
//- (void)shareLocalVedioToPlatformType:(UMSocialPlatformType)platformType Title:(NSString *)title descr:(NSString *)descr thumImage:(NSString *)thumbURL;
@end
