//
//  MineCollectionView.h
//  Zimu
//
//  Created by Redpower on 2017/4/24.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineCollectionViewDelegate <NSObject>

//显示settingView
- (void)settingViewShow;

//关闭settingView
- (void)settingViewHidden;

@end

@interface MineCollectionView : UICollectionView

@property (nonatomic, weak) id<MineCollectionViewDelegate> mineDelegate;

@end
