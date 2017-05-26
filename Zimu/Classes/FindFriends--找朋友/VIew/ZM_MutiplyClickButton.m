//
//  ZM_MutiplyClickButton.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "ZM_MutiplyClickButton.h"

@interface ZM_MutiplyClickButton ()

@property (nonatomic, strong) NSArray *dataSource;


@end

@implementation ZM_MutiplyClickButton



- (instancetype)initWithDataSource:(NSArray *)dataSource{
    self = [super init];
    if (self) {
        _curIndex = 0;
        _dataSource = dataSource;
        [self setTitle:dataSource[0] forState:UIControlStateNormal];
        [self addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)didClickButton:(UIButton *)button{
    //回到主线程修改界面
    
//    dispatch_async(dispatch_get_main_queue(), ^{
    NSLog(@"%zd", _curIndex);
    [self.delegate didClickBtnWithIndex:_curIndex];
    NSLog(@"%zd", _curIndex);

    _curIndex ++;
    NSLog(@"%zd", _curIndex);

        //限制数组不越界
        if (_curIndex >= _dataSource.count) {
            _curIndex = _dataSource.count - 1;
        }
        [button setTitle:_dataSource[_curIndex] forState:UIControlStateNormal];
//    });
    
}
- (void)revertLastState{
    if (_curIndex >= 1) {
        _curIndex --;
    }
    //在回到上个状态的时候先减小标记值再修改界面,回到主线程修改
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setTitle:_dataSource[_curIndex] forState:UIControlStateNormal];
//        [self.delegate didClickBtnWithIndex:_curIndex];
    });
}

- (void)initBtnState{
    _curIndex = 0;
    //在回到上个状态的时候先减小标记值再修改界面,回到主线程修改
    [self setTitle:_dataSource[0] forState:UIControlStateNormal];
}

- (void)setCurIndex:(NSInteger)curIndex{
//    _curIndex = curIndex;
//    [self setTitle:_dataSource[_curIndex] forState:UIControlStateNormal];
    NSLog(@"这个值不能修改");
}
@end
