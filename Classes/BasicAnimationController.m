//
//  BasicANimationController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/8.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "BasicANimationController.h"

@interface BasicAnimationController ()

@property (nonatomic, strong) UIImageView *imgView ;

@end

@implementation BasicAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CABasicAnimation";
    
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.jpg"]];
    _imgView.frame = CGRectMake(80, 180, 100, 100);
    [self.view addSubview:_imgView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
#warning 想要在根层执行动画效果 , 就必须使用 核心动画<Core Animation>
    /**
     *  核心动画只是一个假象 , 控件真是的尺寸并没有发生变化 , 如想要让其大小发生变化, 看以下解决方案:
     *  case1: 可设置其动画的代理 , 在动画完成后改变大小
     *  case2: 将动画保存为执行之后的状态 , 默认是动画执行之前的状态
     */
    //  CABasicAnimation    继承与 CAPropertyAnimation
    //  CAPropertyAnimation 继承与 CAAnimation<抽象类>
    
    
    [self opacityAnimation];
}

/**
 *  动画结束的代理方法
 */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
    
    self.imgView.layer.bounds = CGRectMake(0, 0, 150, 150) ;
}
/**
 *  动画开始的代理方法
 */
- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}

#pragma mark - 动画效果案例

/**
 *  transform.scale 动画
 */
- (void)transformScaleAnimation
{
    // 1. 创建核心动画
    CABasicAnimation *animation = [CABasicAnimation animation] ;
    
    // 设置动画的时间
    animation.duration = 2 ;
    
    // 2. 设置keyPath , 也就是对应的layer的property
    animation.keyPath = @"transform.scale";
    
    // 3. 设置每次动画执行的 "增加值"
    // 若keyPath 为 transform.scale , 则byValue的值为NSNumber
    // 若keyPath 为 transform.scale.x 或 transform.translation.y , 则byValue的值为NSNumber
    // 分别表示X , Y轴的缩放
    animation.byValue = @(1.5);
    
    // 4.1 设置代理 , 可在动画执行的 "开始" 和 "结束" 后做其他操作
    //    animation.delegate = self ;
    
    // 4.2
    animation.removedOnCompletion = NO ;        //动画结束后不要移除
    animation.fillMode = kCAFillModeForwards ;  //保持动画结束后的状态
    
    // 5. 最后将动画添加到layer上
    [self.imgView.layer addAnimation:animation forKey:nil];
}

/**
 *  transform.rotation 动画
 */
- (void)transformRotationAnimation
{
    // 1. 创建核心动画
    CABasicAnimation *animation = [CABasicAnimation animation] ;
    
    // 设置动画的时间
    animation.duration = 2 ;
    
    // 2. 设置keyPath , 也就是对应的layer的property
    animation.keyPath = @"transform.rotation.y";
    
    // 3. 设置每次动画执行的 "增加值"
    // 若keyPath 为 transform.rotation , 则byValue的值为NSNumber
    // 若keyPath 为 transform.rotation.x 或 transform.rotation.y , 则byValue的值为NSNumber
    //    animation.byValue = [NSValue valueWithCGSize:CGSizeMake(10, 10)];
    animation.byValue = @(M_PI_4);
    
    // 4.1 设置代理 , 可在动画执行的 "开始" 和 "结束" 后做其他操作
    //    animation.delegate = self ;
    
    // 4.2
    animation.removedOnCompletion = NO ;        //动画结束后不要移除
    animation.fillMode = kCAFillModeForwards ;  //保持动画结束后的状态
    
    // 5. 最后将动画添加到layer上
    [self.imgView.layer addAnimation:animation forKey:nil];
}

/**
 *  transform.translation 动画
 */
- (void)transformTranslationAnimation
{
    // 1. 创建核心动画
    CABasicAnimation *animation = [CABasicAnimation animation] ;
    
    // 设置动画的时间
    animation.duration = 2 ;
    
    // 2. 设置keyPath , 也就是对应的layer的property
    animation.keyPath = @"transform.translation.y";
    
    // 3.1 设置动画的初始状态
    //    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    //
    //    // 3.1 设置动画的最终状态
    //    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(180, 180)];
    
    // 3.3 设置每次动画执行的 "增加值"
    // 若keyPath 为 transform.translation , 则byValue的值为CGPoint 或者 CGSize 都可以
    // 若keyPath 为 transform.translation.x 或 transform.translation.x , 则byValue的值为NSNumber
//    animation.byValue = [NSValue valueWithCGSize:CGSizeMake(10, 10)];
    animation.byValue = @10;
    
    // 4.1 设置代理 , 可在动画执行的 "开始" 和 "结束" 后做其他操作
    //    animation.delegate = self ;
    
    // 4.2
    animation.removedOnCompletion = NO ;        //动画结束后不要移除
    animation.fillMode = kCAFillModeForwards ;  //保持动画结束后的状态
    
    // 5. 最后将动画添加到layer上
    [self.imgView.layer addAnimation:animation forKey:nil];
}

/**
 *  position 动画
 */
- (void)positionAnimation
{
    // 1. 创建核心动画
    CABasicAnimation *animation = [CABasicAnimation animation] ;
    
    // 设置动画的时间
    animation.duration = 2 ;
    
    // 2. 设置keyPath , 也就是对应的layer的property
    animation.keyPath = @"position";
    
    // 3.1 设置动画的初始状态
//    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
//    
//    // 3.1 设置动画的最终状态
//    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(180, 180)];
    
    // 3.3 设置每次动画执行的 "增加值"
    animation.byValue = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    
    // 4.1 设置代理 , 可在动画执行的 "开始" 和 "结束" 后做其他操作
    //    animation.delegate = self ;
    
    // 4.2
    animation.removedOnCompletion = NO ;        //动画结束后不要移除
    animation.fillMode = kCAFillModeForwards ;  //保持动画结束后的状态
    
    // 5. 最后将动画添加到layer上
    [self.imgView.layer addAnimation:animation forKey:nil];
}

/**
 *  opacity 动画
 */
- (void)opacityAnimation
{
    // 1. 创建核心动画
    CABasicAnimation *animation = [CABasicAnimation animation] ;
    
    // 设置动画的时间
    animation.duration = 2 ;
    
    // 2. 设置keyPath , 也就是对应的layer的property
    animation.keyPath = @"opacity";
    
    // 3. 设置动画的最终状态,此处是改变大小 , 利用bounds属性
    animation.toValue = @0.2;
    
    // 4.1 设置代理 , 可在动画执行的 "开始" 和 "结束" 后做其他操作
    //    animation.delegate = self ;
    
    // 4.2
    animation.removedOnCompletion = NO ;        //动画结束后不要移除
    animation.fillMode = kCAFillModeForwards ;  //保持动画结束后的状态
    
    // 5. 最后将动画添加到layer上
    [self.imgView.layer addAnimation:animation forKey:nil];
}

/**
 *  bounds 动画
 */
- (void)boundsAnimation
{
    // 1. 创建核心动画
    CABasicAnimation *animation = [CABasicAnimation animation] ;
    
    // 设置动画的时间
    animation.duration = 2 ;
    
    // 2. 设置keyPath , 也就是对应的layer的property
    animation.keyPath = @"bounds";
    
    // 3. 设置动画的最终状态,此处是改变大小 , 利用bounds属性
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 150, 150)];
    
    // 4.1 设置代理 , 可在动画执行的 "开始" 和 "结束" 后做其他操作
    //    animation.delegate = self ;
    
    // 4.2
    animation.removedOnCompletion = NO ;        //动画结束后不要移除
    animation.fillMode = kCAFillModeForwards ;  //保持动画结束后的状态
    
    // 5. 最后将动画添加到layer上
    [self.imgView.layer addAnimation:animation forKey:nil];
}

@end
