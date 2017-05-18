//
//  FMIntroCellLayoutFrame.h
//  Zimu
//
//  Created by Redpower on 2017/5/16.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDetailModel.h"
#import "VideoDetailModel.h"

@interface FMIntroCellLayoutFrame : NSObject

- (instancetype)initWithFmDetailModel:(FMDetailModel *)fmDetailModel;
@property (nonatomic, strong) FMDetailModel *fmDetailModel;

- (instancetype)initWithVideoDetailModel:(VideoDetailModel *)videoDetailModel;
@property (nonatomic, strong) VideoDetailModel *videoDetailModel;

@property (nonatomic, assign) CGRect titleLabelFrame;
@property (nonatomic, assign) CGRect flagLabelFrame;
@property (nonatomic, assign) CGRect introLabelFrame;

@property (nonatomic, assign) CGFloat cellHeight;



@end
