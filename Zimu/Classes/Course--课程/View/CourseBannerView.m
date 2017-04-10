//
//  CourseBannerView.m
//  Zimu
//
//  Created by Redpower on 2017/4/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CourseBannerView.h"
#import "SDCycleScrollView.h"

#define cycleScrollView_height 200/375.0 * kScreenWidth


@interface CourseBannerView ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;   //轮播

@property (nonatomic, strong) NSArray *imageUrlArray;

@end
@implementation CourseBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    frame.size.height = cycleScrollView_height;
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = themeGray;
        //轮播
        [self addSubview:self.cycleScrollView];
        
    }
    return self;
}

#pragma mark - 轮播
/**
 *  轮播
 */
- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreenWidth, cycleScrollView_height) imageURLStringsGroup:_imageUrlArray];
        _cycleScrollView.delegate = self;
    }
    return _cycleScrollView;
}
//轮播代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"index : %li",index);
}

- (void)setBannerArray:(NSArray *)bannerArray {
    if (_bannerArray != bannerArray) {
        _bannerArray = bannerArray;
//        NSMutableArray *urlArray = [NSMutableArray arrayWithCapacity:_bannerArray.count];
//        for (int index = 0; index < _bannerArray.count; index++) {
//            HomeBannerItems *item = _bannerArray[index];
//            NSString *imageString = item.imgUrl;
//            imageString = [NSString stringWithFormat:@"http://on9fin031.bkt.clouddn.com/%2@",imageString];
//            NSURL *url = [NSURL URLWithString:imageString];
//            [urlArray addObject:url];
//        }
        _cycleScrollView.imageURLStringsGroup = bannerArray;
    }
}

@end
