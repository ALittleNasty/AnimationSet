//
//  PositionAnchorPointController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/2.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "PositionAnchorPointController.h"

@interface PositionAnchorPointController ()

@end

@implementation PositionAnchorPointController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"位置 & 锚点";
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 64.f, 100.f, 100.f)] ;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    CALayer *layer = [CALayer layer] ;
    layer.backgroundColor = [UIColor blueColor].CGColor;
    layer.bounds = CGRectMake(0.f, 0.f, 100.f, 100.f);
    layer.opacity = 0.5 ;
    
    // pisition 决定了layer在父视图中的位置 , 默认为(0, 0)点
    layer.position = CGPointMake(100.f, 100.f) ;
    
    // anchorPoint 锚点: x,y的范围都是(0~1) , 默认为(0.5, 0.5),处于layer的正中心 
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    [redView.layer addSublayer:layer];
}


@end
