//
//  FMListCell.m
//  Zimu
//
//  Created by Redpower on 2017/4/7.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "FMListCell.h"
#import "FMListCollectionView.h"

@interface FMListCell ()
@property (weak, nonatomic) IBOutlet FMListCollectionView *fmListCollectionView;

@end

@implementation FMListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataArray:(NSArray *)dataArray{
    if (_dataArray != dataArray) {
        _dataArray = dataArray;
        _fmListCollectionView.dataArray = dataArray;
    }
}

@end
