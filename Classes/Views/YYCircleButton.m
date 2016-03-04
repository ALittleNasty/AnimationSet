//
//  YYCircleButton.m
//  AnimationSet
//
//  Created by AiDong on 15/12/10.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "YYCircleButton.h"
#import "OBShapedButton.h"

#define AnimationDuration 1.2

@interface YYCircleButton ()

/**
 *  底部的黑色圆盘
 */
@property (nonatomic, strong) UIImageView  *imgView ;

/**
 *  中心的黑色按钮
 */
@property (nonatomic, strong) UIButton     *mainButton ;


@end

@implementation YYCircleButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initAllSubviews];
    }
    return self ;
}

/**
 *  初始化所有子控件
 */
- (void)initAllSubviews
{
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_yuanpan_bg"]];
    _imgView.frame = self.bounds ;
    _imgView.alpha = 0.f ;
    _imgView.userInteractionEnabled = YES ;
    [self addSubview:_imgView];
    
    for (int i = 0; i < 3; i++) {
        
        NSString *imageName = [NSString stringWithFormat:@"circle%d",i+1] ;
        UIImage *img = [UIImage imageNamed:imageName] ;
        
        UIButton *btn = [OBShapedButton buttonWithType:UIButtonTypeCustom] ;
        btn.tag = i ;
        btn.frame = self.imgView.bounds ;
        NSLog(@"%@",NSStringFromCGRect(self.imgView.bounds));
        [btn setBackgroundImage:img forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(otherButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.imgView addSubview:btn];
    }
    
    _mainButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mainButton.bounds = CGRectMake(0.f, 0.f, 112.f, 112.f);
    _mainButton.center = self.imgView.center ;
    [_mainButton setBackgroundImage:[UIImage imageNamed:@"home_btn_dealer_had_bind"] forState:UIControlStateNormal];
    [_mainButton addTarget:self action:@selector(mainButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_mainButton];
}

/**
 *  中心黑色按钮点击事件
 */
- (void)mainButtonAction:(id)sender
{
    CGFloat currentAlpha = self.imgView.alpha ;
    
    // 添加组动画
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation] ;
    groupAnimation.duration = AnimationDuration ;
    
    // 透明动画
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animation] ;
    opacityAnimation.keyPath = @"opacity";
    
    // 缩放动画
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animation];
    scaleAnimation.keyPath = @"transform.scale";
    
    if (currentAlpha == 0) {    // 显示底部黑色圆盘
        
        opacityAnimation.values = @[@0, @0.9, @1] ;
        scaleAnimation.values = @[@0, @1.1, @1];
        
        self.imgView.alpha = 1.f ;
    }else{                      // 隐藏底部黑色圆盘
        
        opacityAnimation.values = @[@1, @0.9, @0] ;
        scaleAnimation.values = @[@1, @1.1, @0];
        
        self.imgView.alpha = 0.f ;
    }
    
    groupAnimation.animations = @[opacityAnimation, scaleAnimation];
    [self.imgView.layer addAnimation:groupAnimation forKey:nil];
}

/**
 *  其他三个黑色扇形按钮点击事件
 */
- (void)otherButtonClick:(OBShapedButton *)btn
{
    [self mainButtonAction:self.mainButton];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(YYCircleButton:didSelectedAtIndex:)])
    {
        [self.delegate YYCircleButton:self didSelectedAtIndex:btn.tag];
    }
}

@end
