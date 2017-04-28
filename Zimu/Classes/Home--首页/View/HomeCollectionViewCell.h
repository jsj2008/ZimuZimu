//
//  HomeCollectionViewCell.h
//  Zimu
//
//  Created by Redpower on 2017/4/17.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomeCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy) NSString *titleString;  //标题
@property (nonatomic, copy) NSString *titleImageString;
@property (nonatomic, copy) NSString *bgimageString;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, copy) NSString *coverImageString;

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIImageView *titleImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;



@end
