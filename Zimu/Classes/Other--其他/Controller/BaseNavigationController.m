//
//  BaseNavigationController.m
//  Demo
//
//  Created by Redpower on 2017/2/15.
//  Copyright © 2017年 Redpower. All rights reserved.
//

#import "BaseNavigationController.h"
#import "UIBarButtonItem+ZMExtension.h"
#import "AnimationContoller.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *screenShotImageView;     //页面截图
@property (nonatomic, strong) UIView *coverView;                    //蒙版
@property (nonatomic, strong) NSMutableArray *screenShotArray;      //截图数组
@property (nonatomic, strong) UIImage *nextVCScreenShotImg;         //下一个控制器的截图
@property (nonatomic, strong) AnimationContoller *animationController;

@property (nonatomic, strong) NSArray *forbiddenVCArray;        //禁用手势的控制器

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar setShadowImage:[UIImage new]];
    
//    self.interactivePopGestureRecognizer.delegate = self;
    
    self.delegate = self;
    
    //设置导航栏栏标题字体
    UIFont *font = [UIFont systemFontOfSize:18.f];
    NSDictionary *textAttributes = @{
                                     NSFontAttributeName : font,
                                     NSForegroundColorAttributeName : [UIColor colorWithHexString:@"222222"]
                                     };
    [[UINavigationBar appearance] setTitleTextAttributes:textAttributes];

    
    /*1.创建pan手势识别器，并绑定监听方法*/
    _panGestureRec = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(panGestureRec:)];
    _panGestureRec.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:_panGestureRec];
    
    /*2.创建截图的imageView*/
    _screenShotImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    /*3.创建覆盖在截图上的半透明遮罩*/
    _coverView = [[UIView alloc]initWithFrame:_screenShotImageView.frame];
    _coverView.backgroundColor = themeBlack;
    /*4.初始化截图Array*/
    _screenShotArray = [NSMutableArray array];
    
    //禁用手势的控制器
    self.forbiddenVCArray = @[@"HomeVideoDetailViewController"];
//    _panGestureRec.enabled = YES;
}

- (void)panGestureRec:(UIScreenEdgePanGestureRecognizer *)panGestureRec{
    //如果当前控制器已经是跟控制器了，就不需要做任何切换动画，直接返回
    if (self.visibleViewController == self.viewControllers[0]) return;
    
    //判断pan手势的各阶段
    switch (panGestureRec.state) {
        case UIGestureRecognizerStateBegan:
            
            //开始拖拽
            [self dragBegan];
            
            break;
            
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            
            //结束拖拽
            [self dragEnd];
            
            break;
            
        default:
            
            //正在拖拽
            [self dragging:panGestureRec];
            
            break;
    }
    
}

#pragma mark - 开始拖拽过程，添加截图图片和遮罩
// 默认的将要变透明的遮罩的初始透明度(全黑)
#define kDefaultAlpha 0.6
// 当拖动的距离,占了屏幕的总宽高的3/4时, 就让imageview完全显示，遮盖完全消失
#define kTargetTranslateScale 0.75
/**
 *  开始拖拽
 */
- (void)dragBegan{
    //每次手势开始时，都要添加截图imageView和遮罩cover到window上
    [self.view.window insertSubview:_screenShotImageView atIndex:0];
    [self.view.window insertSubview:_coverView aboveSubview:_screenShotImageView];
    
    //_screenShotImageView显示截图数组中的最后一张图
    _screenShotImageView.image = _screenShotArray.lastObject;
}

/**
 *  正在拖拽
 */
- (void)dragging:(UIScreenEdgePanGestureRecognizer *)panGestureRec{
    //得到手指拖动的位置
    CGFloat offsetX = [panGestureRec translationInView:self.view].x;

    //让整个view平移，挪动整个view
    if (offsetX > 0) {
        self.view.transform = CGAffineTransformMakeTranslation(offsetX, 0);
    }
    
    //计算目前手指拖动位移占屏幕总的宽度的比例，当这个比例达到3/4时，遮罩层完全透明
    double lucency = offsetX / self.view.frame.size.width;
    if (offsetX < kScreenWidth) {
        _screenShotImageView.transform = CGAffineTransformMakeTranslation((offsetX - kScreenWidth) * 0.6, 0);
    }

    double alpha = kDefaultAlpha - (lucency/kTargetTranslateScale) * kDefaultAlpha;
    _coverView.alpha = alpha;
    
}

/**
 *  结束拖拽
 */
- (void)dragEnd{
    // 取出挪动的距离
    CGFloat translateX = self.view.transform.tx;
    // 取出宽度
    CGFloat width = self.view.frame.size.width;
    
    if (translateX <= 40) {
        // 如果手指移动的距离还不到屏幕的一半,往左边挪 (弹回)
        [UIView animateWithDuration:0.3 animations:^{
            // 重要~~让被右移的view弹回归位,只要清空transform即可办到
            self.view.transform = CGAffineTransformIdentity;
            // 让imageView大小恢复默认的translation
            _screenShotImageView.transform = CGAffineTransformMakeTranslation(-ScreenWidth, 0);
            // 让遮盖的透明度恢复默认的alpha 1.0
            _coverView.alpha = kDefaultAlpha;
        } completion:^(BOOL finished) {
            // 重要,动画完成之后,每次都要记得 移除两个view,下次开始拖动时,再添加进来
            [_screenShotImageView removeFromSuperview];
            [_coverView removeFromSuperview];
        }];
    } else {
        // 如果手指移动的距离还超过了屏幕的一半,往右边挪
        [UIView animateWithDuration:0.3 animations:^{
            // 让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform
            self.view.transform = CGAffineTransformMakeTranslation(width, 0);
            // 让imageView位移还原
            _screenShotImageView.transform = CGAffineTransformMakeTranslation(0, 0);
            // 让遮盖alpha变为0,变得完全透明
            _coverView.alpha = 0;
        } completion:^(BOOL finished) {
            // 重要~~让被右移的view完全挪到屏幕的最右边,结束之后,还要记得清空view的transform,不然下次再次开始drag时会出问题,因为view的transform没有归零
            self.view.transform = CGAffineTransformIdentity;
            // 移除两个view,下次开始拖动时,再加回来
            [_screenShotImageView removeFromSuperview];
            [_coverView removeFromSuperview];
            
            // 执行正常的Pop操作:移除栈顶控制器,让真正的前一个控制器成为导航控制器的栈顶控制器
            [self popViewControllerAnimated:NO];
            
            // 重要~记得这时候,可以移除截图数组里面最后一张没用的截图了
//             [_screenshotImgs removeLastObject];
            [self.animationController removeLastScreenShot];
        }];
    }
}


////修改返回按钮后，会导致pop手势失效，需重新实现
//- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
//    return self.childViewControllers.count > 1;
//}

//push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    //在制定控制器中禁用手势
    BOOL enable = YES;
    for (NSString *string in _forbiddenVCArray) {
        NSString *className = NSStringFromClass([viewController class]);
        if ([string isEqualToString:className]) {
            enable = NO;
        }
    }
    _panGestureRec.enabled = enable;
    
    //判断是否为栈底控制器，若为栈底则不设置,且不进行截图
    if (self.childViewControllers.count > 0) {
        //调用自定义方法，使用上下文截图
        [self screenShot];
        //push的时候隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //自定义左上角pop返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backBarButtonItemWithImageName:@"navigationButtonReturn" title:@"" target:self action:@selector(back)];
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}




- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0)
{
    self.animationController.navigationOperation = operation;
    self.animationController.navigationController = self;
    //    self.animationController.lastVCScreenShot = self.lastVCScreenShotImg;
    // self.animationController.nextVCScreenShot = self.nextVCScreenShotImg;
    return self.animationController;
}
- (AnimationContoller *)animationController
{
    if (_animationController == nil) {
        _animationController = [[AnimationContoller alloc]init];
        
    }
    return _animationController;
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated{
    
    NSInteger index = self.viewControllers.count;
    NSString * className = nil;
    if (index >= 2) {
        className = NSStringFromClass([self.viewControllers[index -2] class]);
    }
    
    //在制定控制器中禁用手势
    BOOL enable = YES;
    for (NSString *string in _forbiddenVCArray) {
        if ([string isEqualToString:className]) {
            enable = NO;
        }
    }
    _panGestureRec.enabled = enable;
    
    if (_screenShotArray.count >= index - 1) {
        [_screenShotArray removeLastObject];
    }
    
    
    return [super popViewControllerAnimated:animated];
}
- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    NSInteger removeCount = 0;
    for (NSInteger i = self.viewControllers.count - 1; i > 0; i--) {
        if (viewController == self.viewControllers[i]) {
            break;
        }
        
        [_screenShotArray removeLastObject];
        removeCount ++;
        
    }
    _animationController.removeCount = removeCount;
    return [super popToViewController:viewController animated:animated];
}




//使用上下文截图
- (void)screenShot{
    //获取将要被截图的viewController
    UIViewController *viewController = self.view.window.rootViewController;
    //截图大小
    CGSize size = self.view.bounds.size;
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    // 要裁剪的矩形范围
    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //注：iOS7以后renderInContext：由drawViewHierarchyInRect：afterScreenUpdates：替代
    //判读是导航栏是否有上层的Tabbar  决定截图的对象
    if (self.tabBarController == viewController) {
        [viewController.view drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    } else {
        [self.view drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    }
    //从上下文中取出image
    UIImage *shotImage = UIGraphicsGetImageFromCurrentImageContext();
    if (shotImage) {
        //添加进截图数组
        [_screenShotArray addObject:shotImage];
    }
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
}



@end
