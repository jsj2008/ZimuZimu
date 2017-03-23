//
//  DefaultViewAnimator.m
//  ZLSwipeableViewDemo
//
//  Created by Zhixuan Lai on 10/25/15.
//  Copyright © 2015 Zhixuan Lai. All rights reserved.
//

#import "DefaultViewAnimator.h"

@implementation DefaultViewAnimator

- (CGFloat)degreesToRadians:(CGFloat)degrees {
    return degrees * M_PI / 180;
}

- (CGFloat)radiansToDegrees:(CGFloat)radians {
    return radians * 180 / M_PI;
}

- (void)rotateView:(UIView *)view
         forDegree:(float)degree
          duration:(NSTimeInterval)duration
atOffsetFromCenter:(CGPoint)offset
     swipeableView:(ZLSwipeableView *)swipeableView {
    float rotationRadian = [self degreesToRadians:degree];
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                       view.center = [swipeableView convertPoint:swipeableView.center
                                                        fromView:swipeableView.superview];
                       CGAffineTransform transform =
                           CGAffineTransformMakeTranslation(offset.x, offset.y);
                       transform = CGAffineTransformRotate(transform, rotationRadian);
                       transform = CGAffineTransformTranslate(transform, -offset.x, -offset.y);
                       view.transform = transform;
                     }
                     completion:nil];
}

- (void)translateView:(UIView *)view forDistance:(CGFloat)distance scaleX:(CGFloat)scaleX scaleY:(CGFloat)scaleY duration:(NSTimeInterval)duration atOffsetFromCenter:(CGPoint)offset swipeableView:(ZLSwipeableView *)swipeableView{
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
//        view.center = [swipeableView convertPoint:swipeableView.center
//                                         fromView:swipeableView.superview];
//        CGAffineTransform transform =
//        CGAffineTransformMakeTranslation(offset.x, offset.y);
//        transform = CGAffineTransformRotate(transform, rotationRadian);
//        transform = CGAffineTransformTranslate(transform, -offset.x, -offset.y);
//        view.transform = transform;
        view.center = [swipeableView convertPoint:swipeableView.center fromView:swipeableView.superview];
        CGAffineTransform transform = CGAffineTransformMakeTranslation(offset.x, offset.y);
        transform = CGAffineTransformTranslate(transform, 0, distance);
        transform = CGAffineTransformScale(transform, scaleX, scaleY);
        view.transform = transform;
        
    } completion:nil];
}

- (void)animateView:(UIView *)view
              index:(NSUInteger)index
              views:(NSArray<UIView *> *)views
      swipeableView:(ZLSwipeableView *)swipeableView {
    CGFloat degree = 1;
    NSTimeInterval duration = 0.4;
    CGPoint offset = CGPointMake(0, 0);//CGPointMake(0, CGRectGetHeight(swipeableView.bounds) * 0.3);
    switch (index) {
    case 0:
        [self rotateView:view
                     forDegree:0
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
            
//            [self translateView:view
//                    forDistance:0
//                         scaleX:1
//                         scaleY:1
//                       duration:duration
//             atOffsetFromCenter:offset
//                  swipeableView:swipeableView];
        break;
    case 1:
        [self rotateView:view
                     forDegree:degree
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
            
//            [self translateView:view
//                    forDistance:6
//                         scaleX:0.9
//                         scaleY:1
//                       duration:duration
//             atOffsetFromCenter:offset
//                  swipeableView:swipeableView];
        break;
    case 2:
        [self rotateView:view
                     forDegree:-degree
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
            
//            [self translateView:view
//                    forDistance:12
//                         scaleX:0.85
//                         scaleY:1
//                       duration:duration
//             atOffsetFromCenter:offset
//                  swipeableView:swipeableView];
        break;
    case 3:
        [self rotateView:view
                     forDegree:0
                      duration:duration
            atOffsetFromCenter:offset
                 swipeableView:swipeableView];
            
//            [self translateView:view
//                    forDistance:18
//                         scaleX:0.80
//                         scaleY:1
//                       duration:duration
//             atOffsetFromCenter:offset
//                  swipeableView:swipeableView];
        break;
    default:
        break;
    }
}

@end
