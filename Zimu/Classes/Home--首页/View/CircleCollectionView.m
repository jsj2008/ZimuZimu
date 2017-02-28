//
//  CircleCollectionView.m
//  Zimu
//
//  Created by Redpower on 2017/2/27.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "CircleCollectionView.h"
#import "CircleCollectionViewCell.h"
#import "UIImage+ZMExtension.h"

static NSString *identifier = @"circleCollectionViewCell";

@interface CircleCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@end

@implementation CircleCollectionView


- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc]init];
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _layout;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame collectionViewLayout:self.layout];
    if (self) {
        
        //注册单元格
        [self registerNib:[UINib nibWithNibName:@"CircleCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:identifier];
        
        self.backgroundColor = [UIColor clearColor];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CircleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[CircleCollectionViewCell alloc]init];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    //图片
    UIImage *image = [UIImage imageNamed:_dataArray[indexPath.row]];
    cell.circleImageView.image = [image imageAddCornerWithRadious:cell.circleImageView.width/2.0 size:cell.circleImageView.size];
//    NSString *urlString = [NSString stringWithFormat:@"http://www.baifenxian.com%@",_dataArray[indexPath.row]];
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//    NSURL *url = [NSURL URLWithString:urlString];
//    [cell. sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bfx-logo"]];
    
    //文字
    cell.nameLabel.text = _dataArray[indexPath.row];
    cell.nameLabel.textColor = themeBlack;
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (kScreenWidth - 10 * 5)/4.0;
    return CGSizeMake(width, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CircleCollectionViewCell *cell = (CircleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"text : %@",cell.nameLabel.text);
    
}

@end
