//
//  YXSliderBar.m
//  BFXianDemo1
//
//  Created by lj on 16/6/14.
//  Copyright © 2016年 BFXian. All rights reserved.
//

#import "YXSliderBar.h"
#import "YXSlideBarItem.h"

#define DEVICE_WIDTH CGRectGetWidth([UIScreen mainScreen].bounds)
#define DEFAULT_SLIDER_COLOR themeRed
#define SLIDER_VIEW_HEIGHT 2

@interface YXSliderBar () <YXSlideBarItemDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *items;
@property (strong, nonatomic) UIView *sliderView;

@property (strong, nonatomic) YXSlideBarItem *selectedItem;
@property (strong, nonatomic) YXSlideBarItemSelectedCallback callback;

@end

@implementation YXSliderBar

#pragma mark - Lifecircle

- (instancetype)init {
    CGRect frame = CGRectMake(0, 20, DEVICE_WIDTH, 46);
    return [self initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        [self initScrollView];
        [self initSliderView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame isFit:(BOOL)fit{
    if (self= [super initWithFrame:frame]) {
        _items = [NSMutableArray array];
        self.isFitPrinter = fit;
        [self initScrollView];
        [self initSliderView];
    }
    return self;
}
#pragma - mark Custom Accessors

- (void)setItemsTitle:(NSArray *)itemsTitle {
    _itemsTitle = itemsTitle;
    if (self.isFitPrinter) {
        [self setupItemsFit];
    }else{
        [self setupItems];
    }
}

- (void)setItemColor:(UIColor *)itemColor {
    for (YXSlideBarItem *item in _items) {
        [item setItemTitleColor:itemColor];
    }
}

- (void)setItemSelectedColor:(UIColor *)itemSelectedColor {
    for (YXSlideBarItem *item in _items) {
        [item setItemSelectedTitleColor:itemSelectedColor];
    }
}

- (void)setSliderColor:(UIColor *)sliderColor {
    _sliderColor = sliderColor;
    self.sliderView.backgroundColor = _sliderColor;
}

- (void)setSelectedItem:(YXSlideBarItem *)selectedItem {
    _selectedItem.selected = NO;
    _selectedItem = selectedItem;
}


#pragma - mark Private

- (void)initScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
}

- (void)initSliderView {
    _sliderView = [[UIView alloc] init];
    _sliderColor = DEFAULT_SLIDER_COLOR;
    _sliderView.backgroundColor = _sliderColor;
    [_scrollView addSubview:_sliderView];
}

- (void)setupItems {
    CGFloat itemX = 0;
    for (NSString *title in _itemsTitle) {
        YXSlideBarItem *item = [[YXSlideBarItem alloc] init];
        item.delegate = self;
        
        // Init the current item's frame
        CGFloat itemW = [YXSlideBarItem widthForTitle:title];
        item.frame = CGRectMake(itemX, 0, itemW, CGRectGetHeight(_scrollView.frame));
        [item setItemTitle:title];
        [_items addObject:item];
        
        [_scrollView addSubview:item];
        
        // Caculate the origin.x of the next item
        itemX = CGRectGetMaxX(item.frame);
    }
    
    // Cculate the scrollView 's contentSize by all the items
    _scrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_scrollView.frame));
    
    // Set the default selected item, the first item
    YXSlideBarItem *firstItem = [self.items firstObject];
    firstItem.selected = YES;
    _selectedItem = firstItem;
    
    // Set the frame of sliderView by the selected item
    
    _sliderView.frame = CGRectMake(_isFitPrinter?firstItem.frame.size.width / 3:0, self.frame.size.height - SLIDER_VIEW_HEIGHT, _isFitPrinter?firstItem.frame.size.width / 3:firstItem.frame.size.width, SLIDER_VIEW_HEIGHT);
}
- (void)setupItemsFit {
    CGFloat itemX = 0;
    for (NSString *title in _itemsTitle) {
        YXSlideBarItem *item = [[YXSlideBarItem alloc] init];
        item.delegate = self;
        
        // Init the current item's frame
        CGFloat itemW = kScreenWidth / 2;
        item.frame = CGRectMake(itemX, 0, itemW, CGRectGetHeight(_scrollView.frame));
        [item setItemTitle:title];
        [_items addObject:item];
        
        [_scrollView addSubview:item];
        
        // Caculate the origin.x of the next item
        itemX = CGRectGetMaxX(item.frame);
    }
    
    // Cculate the scrollView 's contentSize by all the items
    _scrollView.contentSize = CGSizeMake(itemX, CGRectGetHeight(_scrollView.frame));
    
    // Set the default selected item, the first item
    YXSlideBarItem *firstItem = [self.items firstObject];
    firstItem.selected = YES;
    _selectedItem = firstItem;
    
    // Set the frame of sliderView by the selected item
    _sliderView.frame = CGRectMake(firstItem.frame.size.width / 3, self.frame.size.height - SLIDER_VIEW_HEIGHT, firstItem.frame.size.width / 3, SLIDER_VIEW_HEIGHT);
}

- (void)scrollToVisibleItem:(YXSlideBarItem *)item {
    NSInteger selectedItemIndex = [self.items indexOfObject:_selectedItem];
    NSInteger visibleItemIndex = [self.items indexOfObject:item];
    
    // If the selected item is same to the item to be visible, nothing to do
    if (selectedItemIndex == visibleItemIndex) {
        return;
    }
    
    CGPoint offset = _scrollView.contentOffset;
    
    // If the item to be visible is in the screen, nothing to do
    if (CGRectGetMinX(item.frame) >= offset.x && CGRectGetMaxX(item.frame) <= (offset.x + CGRectGetWidth(_scrollView.frame))) {
        return;
    }
    
    // Update the scrollView's contentOffset according to different situation
    if (selectedItemIndex < visibleItemIndex) {
        // The item to be visible is on the right of the selected item and the selected item is out of screeen by the left, also the opposite case, set the offset respectively
        if (CGRectGetMaxX(_selectedItem.frame) < offset.x) {
            offset.x = CGRectGetMinX(item.frame);
        } else {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        }
    } else {
        // The item to be visible is on the left of the selected item and the selected item is out of screeen by the right, also the opposite case, set the offset respectively
        if (CGRectGetMinX(_selectedItem.frame) > (offset.x + CGRectGetWidth(_scrollView.frame))) {
            offset.x = CGRectGetMaxX(item.frame) - CGRectGetWidth(_scrollView.frame);
        } else {
            offset.x = CGRectGetMinX(item.frame);
        }
    }
    _scrollView.contentOffset = offset;
}

- (void)addAnimationWithSelectedItem:(YXSlideBarItem *)item {
    // Caculate the distance of translation
    CGFloat dx = CGRectGetMidX(item.frame) - CGRectGetMidX(_selectedItem.frame);
    
    // Add the animation about translation  位置动画
    CABasicAnimation *positionAnimation = [CABasicAnimation animation];
    positionAnimation.keyPath = @"position.x";
    positionAnimation.fromValue = @(_sliderView.layer.position.x);
    positionAnimation.toValue = @(_sliderView.layer.position.x + dx);
    
    // Add the animation about size 尺寸动画
    CABasicAnimation *boundsAnimation = [CABasicAnimation animation];
    boundsAnimation.keyPath = @"bounds.size.width";
    boundsAnimation.fromValue = @(CGRectGetWidth(_sliderView.layer.bounds));
    CGFloat width = _isFitPrinter?CGRectGetWidth(item.frame) / 3:CGRectGetWidth(item.frame);
    boundsAnimation.toValue = @(width);
    
    // Combine all the animations to a group
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[positionAnimation, boundsAnimation];
    animationGroup.duration = 0.2;
    [_sliderView.layer addAnimation:animationGroup forKey:@"basic"];
    
    // Keep the state after animating
    _sliderView.layer.position = CGPointMake(_sliderView.layer.position.x + dx, _sliderView.layer.position.y);
    CGRect rect = _sliderView.layer.bounds;
//    CGFloat width = _isFitPrinter?CGRectGetWidth(item.frame) / 3:CGRectGetWidth(item.frame);
    rect.size.width = width;
    _sliderView.layer.bounds = rect;
}

#pragma mark - Public

- (void)slideBarItemSelectedCallback:(YXSlideBarItemSelectedCallback)callback {
    _callback = callback;
}

- (void)selectSlideBarItemAtIndex:(NSUInteger)index {
    YXSlideBarItem *item = [self.items objectAtIndex:index];
    if (item == _selectedItem) {
        return;
    }
    
    item.selected = YES;
    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item];
    self.selectedItem = item;
}

#pragma mark - FDSlideBarItemDelegate

- (void)slideBarItemSelected:(YXSlideBarItem *)item {
    if (item == _selectedItem) {
        return;
    }
    
    [self scrollToVisibleItem:item];
    [self addAnimationWithSelectedItem:item];
    self.selectedItem = item;
    _callback([self.items indexOfObject:item]);
}

@end
