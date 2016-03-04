//
//  CustomLayerUsageController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/8.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "CustomLayerUsageController.h"
#import "YYLayer.h"

@interface CustomLayerUsageController ()

@end

@implementation CustomLayerUsageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"自定义Layer";
    
    UIView *tempView = [[UIView alloc] init];
    tempView.frame = CGRectMake(100, 100, 100, 100);
    tempView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:tempView];
    
    YYLayer *layer = [YYLayer layer] ;
    layer.backgroundColor = [UIColor greenColor].CGColor;
    
    layer.bounds = CGRectMake(0.f, 0.f, 150.f, 150.f);
    
    layer.anchorPoint = CGPointMake(0.f, 0.f) ;
    
    // 加入要让自定义的layer显示drawInContext里面绘制的内容的话 , 必须调用一个方法:
    [layer setNeedsDisplay];
    
    [tempView.layer addSublayer:layer];
}


@end
