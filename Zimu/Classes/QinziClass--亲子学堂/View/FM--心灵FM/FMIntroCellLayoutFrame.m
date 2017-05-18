//
//  FMIntroCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/5/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMIntroCellLayoutFrame.h"
#import "WXLabel.h"

@implementation FMIntroCellLayoutFrame

//电台
- (instancetype)initWithFmDetailModel:(FMDetailModel *)fmDetailModel{
    self = [super init];
    if (self) {
        _fmDetailModel = fmDetailModel;
        [self layoutFMFrame];
    }
    return self;
}
//视频
- (instancetype)initWithVideoDetailModel:(VideoDetailModel *)videoDetailModel{
    self = [super init];
    if (self) {
        _videoDetailModel = videoDetailModel;
        [self layoutVideoFrame];
    }
    return self;
}

- (void)layoutFMFrame{
    
    //标题
    NSString *title = _fmDetailModel.fmTitle;
    CGFloat height = [WXLabel getTextHeight:16 width:kScreenWidth - 20 text:title linespace:1.5];
    _titleLabelFrame = CGRectMake(10, 10, kScreenWidth - 20, height);
    
    //标签&时间
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    _flagLabelFrame = CGRectMake(CGRectGetMinX(_titleLabelFrame), CGRectGetMaxY(_titleLabelFrame) + 3, kScreenWidth - 20, size.height);
    
    //介绍
    title = _fmDetailModel.fmProfile;
    height = [WXLabel getTextHeight:13 width:kScreenWidth - 20 text:title linespace:1.5];
    _introLabelFrame = CGRectMake(10, CGRectGetMaxY(_flagLabelFrame) + 8, kScreenWidth - 20, height);
    
    //高度
    _cellHeight = CGRectGetMaxY(_introLabelFrame) + 10;
}

- (void)layoutVideoFrame{
    
    //标题
    NSString *title = _videoDetailModel.videoTitle;
    CGFloat height = [WXLabel getTextHeight:16 width:kScreenWidth - 20 text:title linespace:1.5];
    _titleLabelFrame = CGRectMake(10, 10, kScreenWidth - 20, height);
    
    //标签&时间
    UIFont *font = [UIFont systemFontOfSize:12];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:font}];
    _flagLabelFrame = CGRectMake(CGRectGetMinX(_titleLabelFrame), CGRectGetMaxY(_titleLabelFrame) + 3, kScreenWidth - 20, size.height);
    
    //介绍
    title = _videoDetailModel.videoProfile;
    height = [WXLabel getTextHeight:13 width:kScreenWidth - 20 text:title linespace:1.5];
    _introLabelFrame = CGRectMake(10, CGRectGetMaxY(_flagLabelFrame) + 8, kScreenWidth - 20, height);
    
    //高度
    _cellHeight = CGRectGetMaxY(_introLabelFrame) + 10;
}
@end
