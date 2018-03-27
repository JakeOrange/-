//
//  ViewController.m
//  CustomHeartAnimation
//
//  Created by 陈鹏 on 2018/3/26.
//  Copyright © 2018年 jasonchen. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+HeartAnimation.h"

@interface ViewController () {
    NSTimer *_burstTimer;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(createAnimate)];
    [self.view addGestureRecognizer:tapGesture];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGesture:)];
    longPressGesture.minimumPressDuration = 0.2;
    [self.view addGestureRecognizer:longPressGesture];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 调用UIImageView分类中封装好的生成动画的方法
 */
- (void)createAnimate {
    NSString *imageName = [self randomGetImageName];
    CGPoint position = CGPointMake(CGRectGetWidth(self.view.bounds) - 60,
                                   CGRectGetHeight(self.view.bounds) - 40);
    
    [UIImageView animateInView:self.view
                     imageName:imageName
                      position:position
                    pathLength:CGRectGetHeight(self.view.bounds) / 2];
}



/**
 长按则不断生成随机图片

 记得释放定时器，防止内存泄漏
 
 @param longPressGesture longPressGesture description
 */
-(void)longPressGesture:(UILongPressGestureRecognizer *)longPressGesture{
    switch (longPressGesture.state) {
        case UIGestureRecognizerStateBegan:
            _burstTimer = [NSTimer scheduledTimerWithTimeInterval:0.6
                                                           target:self
                                                         selector:@selector(createAnimate)
                                                         userInfo:nil
                                                          repeats:YES];
            break;
        case UIGestureRecognizerStateEnded:
            [_burstTimer invalidate];
            _burstTimer = nil;
            break;
        default:
            break;
    }
}


/**
 生成随机图片的名称
 
 @return 图片名称
 */
- (NSString *)randomGetImageName {
    NSString *imageName = nil;
    NSInteger index = arc4random() % 4;
    switch (index) {
        case 0:
            imageName = @"bHeart";
            break;
        case 1:
            imageName = @"gHeart";
            break;
        case 2:
            imageName = @"rHeart";
            break;
        case 3:
            imageName = @"yHeart";
            break;
            
        default:
            imageName = @"bHeart";
            break;
    }
    return imageName;
}

@end


