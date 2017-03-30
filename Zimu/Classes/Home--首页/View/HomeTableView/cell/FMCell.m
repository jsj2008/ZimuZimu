//
//  FMCell.m
//  Zimu
//
//  Created by Redpower on 2017/3/14.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMCell.h"
#import "FMCollectionView.h"

@interface FMCell ()
@property (weak, nonatomic) IBOutlet FMCollectionView *collectionView;

@end
@implementation FMCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setHomeFMModelArray:(NSArray *)homeFMModelArray{
    if (_homeFMModelArray != homeFMModelArray) {
        _homeFMModelArray = homeFMModelArray;
        _collectionView.homeFMModelArray = _homeFMModelArray;
    }
}

@end
