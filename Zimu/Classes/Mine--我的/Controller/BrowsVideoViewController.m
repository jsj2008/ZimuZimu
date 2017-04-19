//
//  BrowsVideoViewController.m
//  Zimu
//
//  Created by 飞飞飞 on 2017/4/6.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "BrowsVideoViewController.h"
#import "BrowsVideoCell.h"

static NSString *videoCellId = @"BrowsVideoCell";

@interface BrowsVideoViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BrowsVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = themeGray;

    [self createCollectionView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createCollectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 1, kScreenWidth, kScreenHeight - 101) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        UINib *nib = [UINib nibWithNibName:videoCellId bundle:[NSBundle mainBundle]];
        [_collectionView registerNib:nib forCellWithReuseIdentifier:videoCellId];
        _collectionView.backgroundColor = themeGray;
        [self.view addSubview:_collectionView];
    }
}

#pragma mark - colectionView代理、数据源
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BrowsVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:videoCellId forIndexPath:indexPath];
    cell.backgroundColor = themeWhite;
    return cell;
}
#pragma mark - delegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(kScreenWidth * 0.5, (kScreenWidth * 0.5 - 17.5) * 0.6 + 37);
}
@end
