//
//  SLDBarView.h
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _SLDBarState{
    SLDBarStateNormal = 0,
    SLDBarStateShadow = 1
}SLDBarState;

@protocol SLDBarViewDelegate <NSObject>

- (void)openSLDTableView;

@end

@interface SLDBarView : UIView

/*普通状态*/
@property (nonatomic, strong) UILabel *normalNameLabel;
@property (nonatomic, strong) UIButton *openButton;

/*阴影状态*/
@property (nonatomic, strong) UIView *shadowBGView;
@property (nonatomic, strong) UILabel *shadowNameLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UILabel *tagLabel1;
@property (nonatomic, strong) UILabel *tagLabel2;
@property (nonatomic, strong) UILabel *tagLabel3;
@property (nonatomic, strong) UILabel *dataLabel;



@property (nonatomic, weak) id<SLDBarViewDelegate> delegate;

- (void)LSDBarTransformWithSLDBarState:(SLDBarState)SLDBarState;

@end
