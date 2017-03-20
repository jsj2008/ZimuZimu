//
//  HomeArrayDataSource.h
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^HomeTableViewCellBlock)(id cell, id text);


@interface HomeArrayDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSArray *titleArray;

- (instancetype)initWithDataArray:(NSArray *)dataArray cellIdentifier:(NSString *)cellIdentifier;
//- (instancetype)initWithDataArray:(NSArray *)dataArray cellIdentifier:(NSString *)cellIdentifier homeTableViewCellBlock:(HomeTableViewCellBlock)block;


@end
