//
//  ShakeAnimationController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "ShakeAnimationController.h"

@interface ShakeAnimationController ()

@property (nonatomic, strong) UIImageView *imgView ;
@property (nonatomic, strong) UIButton    *startButton ;
@property (nonatomic, strong) UIButton    *endButton ;

@end

@implementation ShakeAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"抖动效果";
    
    [self initSubviews];
}
#pragma mark - init subviews
- (void)initSubviews
{
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.jpg"]];
    _imgView.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:_imgView];
    
    _startButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _startButton.frame = CGRectMake(50, 240, 80, 40);
    _startButton.backgroundColor = [UIColor greenColor];
    [_startButton setTitle:@"start" forState:UIControlStateNormal];
    [_startButton addTarget:self action:@selector(startButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_startButton];
    
    
    _endButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _endButton.frame = CGRectMake(200, 240, 80, 40);
    _endButton.backgroundColor = [UIColor greenColor];
    [_endButton setTitle:@"end" forState:UIControlStateNormal];
    [_endButton addTarget:self action:@selector(endButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_endButton];
}

#pragma mark - startButtonAction
- (void)startButtonAction:(UIButton *)btn
{
    // 抖动图片 , 利用 "帧动画" 设置图片的 "旋转" 路径
    // 创建 CAKeyframeAnimation
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animation] ;
    
    // 设置 keyPath
    rotationAnimation.keyPath = @"transform.rotation";
    
    // 设置左右旋转地弧度
    rotationAnimation.values = @[@(-M_PI_4/4) , @(M_PI_4/4) , @(-M_PI_4/4)];
    
    // 设置动画执行的次数为: MAXFLOAT
    rotationAnimation.repeatCount = MAXFLOAT ;
    
    // 设定每次动画的时间
    rotationAnimation.duration = 0.4;
    
    // 将动画添加到layer上
    [self.imgView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}
#pragma mark - endButtonAction
- (void)endButtonAction:(UIButton *)btn
{
    // 通过 "key" 将动画移除 , 停止动画
    [self.imgView.layer removeAnimationForKey:@"rotationAnimation"];
}

@end
