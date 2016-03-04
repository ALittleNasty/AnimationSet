//
//  AnimationGroupController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "AnimationGroupController.h"

@interface AnimationGroupController ()

@property (nonatomic, strong) UIImageView *imgView ;

@end

@implementation AnimationGroupController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"组动画";
    
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"a2.JPG"]];
    _imgView.frame = CGRectMake(0.f, 64.f, 100.f, 100.f) ;
    [self.view addSubview:_imgView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1.创建组动画
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    // 2.设置组动画的每一种动画效果
    
    // 2.1 设置平移动画
    CABasicAnimation *positionAnimation = [CABasicAnimation animation] ;
    positionAnimation.keyPath = @"position";
    positionAnimation.toValue = (id)[NSValue valueWithCGPoint:self.view.center];

    // 2.2 设置缩放动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animation];
    scaleAnimation.keyPath = @"transform.scale" ;
    scaleAnimation.toValue = @2.5;
    
    // 2.3 设置旋转动画
    CABasicAnimation *rotationAnimation = [CABasicAnimation animation];
    rotationAnimation.keyPath = @"transform.rotation";
    rotationAnimation.toValue = @(M_PI*2);

    // 2.4 将这三中动画添加到动画数组中
    animationGroup.animations = @[positionAnimation, scaleAnimation, rotationAnimation];
    
    // 3. 设置动画时间
    double animationDuration = 1.5 ;
    animationGroup.duration = animationDuration ;
    
    // 4. 动画结束后不移除, 并保持动画的最终状态
    animationGroup.removedOnCompletion = NO ;
    animationGroup.fillMode = kCAFillModeForwards ;
    
    // 5.将组动画添加到layer上
    [self.imgView.layer addAnimation:animationGroup forKey:nil];
}

@end
