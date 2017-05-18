//
//  FMPlayView.h
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMDetailModel.h"

//@protocol FMPlayViewDelegate <NSObject>
//
////下一曲
//- (void)nextSong;
//
////上一曲
//- (void)previousSong;
//
//@end

@interface FMPlayView : UIView

@property (nonatomic, copy) NSString *fmURL;
//@property (nonatomic, strong) NSArray *fmURLArray;
@property (nonatomic, strong) FMDetailModel *fmDetailModel;


//- (instancetype)initWithFrame:(CGRect)frame fmURLArray:(NSArray *)fmURLArray;     //暂时不要
//- (instancetype)initWithFrame:(CGRect)frame fmDetailModel:(FMDetailModel *)fmDetailModel;

//@property (nonatomic, assign) id<FMPlayViewDelegate> delegate;


- (void)initAudioPlayer;

@end
