//
//  FMPlayView.h
//  Zimu
//
//  Created by Redpower on 2017/3/30.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMPlayViewDelegate <NSObject>

//下一曲
- (void)nextSong;

//上一曲
- (void)previousSong;

@end

@interface FMPlayView : UIView

@property (nonatomic, copy) NSString *fmURL;
@property (nonatomic, strong) NSArray *fmURLArray;


- (instancetype)initWithFrame:(CGRect)frame fmURLArray:(NSArray *)fmURLArray;
@property (nonatomic, assign) id<FMPlayViewDelegate> delegate;


- (void)initAudioPlayer;

@end
