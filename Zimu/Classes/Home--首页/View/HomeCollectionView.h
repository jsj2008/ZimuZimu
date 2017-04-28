//
//  HomeCollectionView.h
//  Zimu
//
//  Created by Redpower on 2017/4/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeCollectionViewCell.h"

@class HomeCollectionView;
@protocol CollectionViewDelegate <NSObject>

- (void)collectionView:(HomeCollectionView *)collectionView didSelectCell:(HomeCollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath;

@end

@interface HomeCollectionView : UICollectionView

@property (nonatomic, assign) id<CollectionViewDelegate> collectionDelegate;


@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *modelArray;

@end
