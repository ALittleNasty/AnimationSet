//
//  KeyFrameAnimationController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "KeyFrameAnimationController.h"


#define kFullWidth    [UIScreen mainScreen].bounds.size.width
#define kFullHeight   [UIScreen mainScreen].bounds.size.height

@interface KeyFrameAnimationController ()

@property (nonatomic, strong) UIView *blueView ;
@property (nonatomic, strong) UIImageView *imgView ;

@end

@implementation KeyFrameAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帧动画";
    // 帧动画: 沿着指定路径执行的动画叫做 "帧动画"
    
    [self initSubviews];
}

/**
 *  初始化子视图
 */
- (void)initSubviews
{
    UIView *circleView = [[UIView alloc] init];
    circleView.backgroundColor = [UIColor greenColor];
    circleView.frame = CGRectMake(0.f, 64.f, kFullWidth, kFullWidth);
    circleView.layer.cornerRadius = kFullWidth / 2 ;
    [self.view addSubview:circleView];
    
    _blueView = [[UIView alloc] init];
    _blueView.frame = CGRectMake(0.f, 64.f, 50.f, 50.f);
    _blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blueView];
    
    
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.jpg"]];
    _imgView.frame = CGRectMake(0.f, 64.f, 100.f, 100.f);
    _imgView.alpha = 0.6 ;
    [self.view addSubview:_imgView];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 1.创建 CAKeyframeAnimation
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    
    // 2.设置动画的 "keyPath"
    animation.keyPath = @"position";
    
    // 3.设置动画的执行过程中的一些 "关键点"
    // 数组中第一个为"开始状态" , 最后一个为"结束状态"
    animation.values = @[ [NSValue valueWithCGPoint:CGPointMake(50.f, 64.f + 50.f)],
                          [NSValue valueWithCGPoint:CGPointMake(kFullWidth-50.f, 64.f + 50.f)],
                          [NSValue valueWithCGPoint:CGPointMake(kFullWidth-50.f, kFullHeight-50.f)],
                          [NSValue valueWithCGPoint:CGPointMake(50.f, kFullHeight-50.f)],
                          [NSValue valueWithCGPoint:CGPointMake(50.f, 64.f + 50.f)] ];
    
    // 4.设置动画的时间
    animation.duration = 5.0 ;
    
    // 5.设置动画的节奏
    /*  
    -------------- Timing function names ----------------
    
    kCAMediaTimingFunctionLinear            线性匀速
    kCAMediaTimingFunctionEaseIn            先慢后快
    kCAMediaTimingFunctionEaseOut           先快后慢
    kCAMediaTimingFunctionEaseInEaseOut     开始和结束比较慢 , 中间过程快
    kCAMediaTimingFunctionDefault           默认的
     
     */
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault] ;
    
#warning 在CAKeyframeAnimation的内部, "path" 的优先级高于 "values" 
    // 6.设置动画的路径 "path"
    CGMutablePathRef path = CGPathCreateMutable() ;
    CGPathAddEllipseInRect(path, NULL, CGRectMake(0.f, 64.f, kFullWidth, kFullWidth));
    animation.path = path ;
    
    // C语言的数据类型, 通过create/copy/retain创建的使用完毕后要释放
    CFRelease(path);
    
    // 7. 动画结束后不要移除 , 并保持动画执行完毕后的状态
    animation.removedOnCompletion = NO ;
    animation.fillMode = kCAFillModeForwards ;
    
    // 8.将动画添加到layer上
    [self.imgView.layer addAnimation:animation forKey:nil];
}

@end
