//
//  UIImageView+HeartAnimation.m
//  CustomHeartAnimation
//
//  Created by 陈鹏 on 2018/3/26.
//  Copyright © 2018年 jasonchen. All rights reserved.
//

#import "UIImageView+HeartAnimation.h"

@implementation UIImageView (HeartAnimation)


/**
 对每个图片进行动画处理
 
 @param view superView
 @param name 进行动画的图片名称
 @param position 动画的起始位置
 @param length 动画执行的路径长度
 */
+ (void)animateInView:(UIView *)view
            imageName:(NSString *)name
             position:(CGPoint)position
           pathLength:(CGFloat)length {
    
    //首先把图片加入superView
    UIImage *image = [UIImage imageNamed:name];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.center = position;
    [view addSubview:imageView];
    
    NSTimeInterval totalAnimationDuration = 6;
    CGFloat heartWidth = CGRectGetWidth(imageView.bounds);
    CGFloat heartCenterX = imageView.center.x;
    
    //开始生成S型贝塞尔路径
    UIBezierPath *heartMovePath = [UIBezierPath bezierPath];
    [heartMovePath moveToPoint:imageView.center];
    
    //随机左右移动  -1 or 1 控制方向
    NSInteger j = arc4random_uniform(2);
    NSInteger moveDirection = 1 - (2 * j);
    
    //在一定范围内生成个随机结束的点
    CGPoint endPoint = CGPointMake(heartCenterX + arc4random_uniform(10) * moveDirection,
                                   position.y - length + arc4random_uniform(10) * moveDirection);
    
    //在一个范围内随机生成control point
    CGFloat xDelta = (heartWidth / 2.0 + arc4random_uniform(2 * heartWidth)) * moveDirection;
    CGFloat yDelta = length / 4 + arc4random_uniform(10);
    CGPoint controlPoint1 = CGPointMake(heartCenterX + xDelta, position.y - yDelta);
    CGPoint controlPoint2 = CGPointMake(heartCenterX - xDelta, position.y - yDelta * 3);
    
    [heartMovePath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    //实现帧动画
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartMovePath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    keyFrameAnimation.duration = totalAnimationDuration;
    keyFrameAnimation.speed = 2;
    [imageView.layer addAnimation:keyFrameAnimation forKey:@"positionFrameAnimation"];
    
    //实现渐隐效果，并在动画结束后移除
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        imageView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}

@end
