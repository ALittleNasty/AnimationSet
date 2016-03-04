//
//  HidenAnimationController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/8.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "HidenAnimationController.h"

@interface HidenAnimationController ()

@property (nonatomic, strong) UIImageView *imgView ;
@property (nonatomic,   weak) CALayer *layer ;

@end

@implementation HidenAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"隐式动画";
    
    [self layoutSubviews];
    
    CALayer *layer = [CALayer layer] ;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.contents = (id)[UIImage imageNamed:@"01.jpg"].CGImage ;
    layer.position = CGPointMake(100, 300);
    [self.view.layer addSublayer:layer];
    _layer = layer ;
}

- (void)layoutSubviews
{
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"01.jpg"]];
    _imgView.frame = CGRectMake(80, 80, 100, 100);
    [self.view addSubview:_imgView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
#warning 根层改变属性是没有动画，只有非根层改变属性就有默认的动画
    //设置根层的大小
    self.imgView.layer.bounds = CGRectMake(0, 0, 150, 150);
    
    //设置非根层的大小
    //想默认动画时间设置长一点
    
    [CATransaction begin];
    //[CATransaction setDisableActions:YES];//关闭隐藏动画
    [CATransaction setAnimationDuration:5];
    
    //看到transform旋转的动画效果
//    self.layer.bounds = CGRectMake(0, 0, 150, 150);
    self.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);
    
    [CATransaction commit];
}

@end
