//
//  FMAuthorCellLayoutFrame.m
//  Zimu
//
//  Created by Redpower on 2017/5/12.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMAuthorCellLayoutFrame.h"
#import "WXLabel.h"

@implementation FMAuthorCellLayoutFrame

- (instancetype)init{
    self = [super init];
    if (self) {
        [self layoutFrames_nodata];
    }
    return self;
}

- (void)layoutFrames_nodata{
    //头像
    CGFloat headImageViewWidth = 55/375.0 * kScreenWidth;
    _headImageViewFrame = CGRectMake(10, 10, headImageViewWidth, headImageViewWidth);
    //圆角
    _coverImageViewFrame = _headImageViewFrame;
    
    //姓名
    NSString *nameString = @"子慕吴东辉";
    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame) + 5, nameSize.width, nameSize.height);
    
    //播放次数
    NSString *playString = @"2.6万次播放";
    CGSize playSize = [playString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    _countLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 5, playSize.width, playSize.height);
    
    //上传时间
    NSString *timeString = @"05-13";
    CGSize timeSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
    _timeLabelFrame = CGRectMake(CGRectGetMaxX(_countLabelFrame) + 15, CGRectGetMinY(_countLabelFrame), timeSize.width, timeSize.height);
    
    _cellHeight = CGRectGetMaxY(_countLabelFrame) + 10;
    
}

- (instancetype)initWithExpertDetailModel:(ExpertDetailModel *)expertDetailModel{
    self = [super init];
    if (self) {
        _expertDetailModel = expertDetailModel;
        [self layoutFrames];
    }
    return self;
}

- (void)layoutFrames{
    //头像
    CGFloat headImageViewWidth = 55/375.0 * kScreenWidth;
    _headImageViewFrame = CGRectMake(10, 10, headImageViewWidth, headImageViewWidth);
    //圆角
    _coverImageViewFrame = _headImageViewFrame;
    
    //姓名
    NSString *nameString = _expertDetailModel.userName;
    CGSize nameSize = [nameString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    _nameLabelFrame = CGRectMake(CGRectGetMaxX(_headImageViewFrame) + 10, CGRectGetMinY(_headImageViewFrame) + 5, nameSize.width, nameSize.height);
    
    //简介
    ExpertInfo *expertInfo = _expertDetailModel.expert;
    NSString *introString = expertInfo.profile;
    CGFloat height = [WXLabel getTextHeight:12 width:kScreenWidth - CGRectGetMinX(_nameLabelFrame) - 10 text:introString linespace:1.5];
    _introLabelFrame = CGRectMake(CGRectGetMinX(_nameLabelFrame), CGRectGetMaxY(_nameLabelFrame) + 5, kScreenWidth - CGRectGetMinX(_nameLabelFrame) - 10, height);
    
    CGFloat cellHeight = CGRectGetMaxY(_introLabelFrame) >= CGRectGetMaxY(_coverImageViewFrame) ? CGRectGetMaxY(_introLabelFrame) : CGRectGetMaxY(_coverImageViewFrame);
    _cellHeight = cellHeight + 10;
    
}

@end
