//
//  UIImageView+HeartAnimation.h
//  CustomHeartAnimation
//
//  Created by 陈鹏 on 2018/3/26.
//  Copyright © 2018年 jasonchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (HeartAnimation)


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
           pathLength:(CGFloat)length;

@end
