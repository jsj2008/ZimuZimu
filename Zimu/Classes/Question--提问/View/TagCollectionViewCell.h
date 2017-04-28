//
//  TagCollectionViewCell.h
//  Zimu
//
//  Created by Redpower on 2017/3/22.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *tagString;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end
