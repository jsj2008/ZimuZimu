//
//  HomeArrayDataSource.m
//  Zimu
//
//  Created by Redpower on 2017/2/23.
//  Copyright © 2017年 Zimu. All rights reserved.
//

#import "HomeArrayDataSource.h"
#import "TestViewController.h"
#import "UIView+ViewController.h"

@interface HomeArrayDataSource ()

@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) HomeTableViewCellBlock homeTableViewCellBlock;

@end

@implementation HomeArrayDataSource

- (instancetype)initWithDataArray:(NSArray *)dataArray cellIdentifier:(NSString *)cellIdentifier homeTableViewCellBlock:(HomeTableViewCellBlock)block{
    if (self == [super init]) {
        
        _titleArray = @[@"热门推荐",@"暖心读物",@"精彩问答",@"完美鸡汤"];

        _dataArray = dataArray;
        _identifier = cellIdentifier;
        _homeTableViewCellBlock = block;
        
    }
    return self;
}



//UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:self.identifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.identifier];
    }
    self.homeTableViewCellBlock(cell, self.dataArray[indexPath.row]);
    
    return cell;
}




#pragma mark - <##>


- (UIViewController*)topViewController
{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    return [self topViewControllerWithRootViewController:window.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController1 = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController1.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}


@end
