//
//  AnimationCircleButtonController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/10.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "AnimationCircleButtonController.h"
#import "YYCircleButton.h"

#define kFullWidth    [UIScreen mainScreen].bounds.size.width
#define kFullHeight   [UIScreen mainScreen].bounds.size.height

@interface AnimationCircleButtonController ()<YYCircleButtonDelegate>

@end

@implementation AnimationCircleButtonController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat position_x = (kFullWidth - 306.f) / 2 ;
    YYCircleButton *circleButton = [[YYCircleButton alloc] initWithFrame:CGRectMake(position_x, 100.f, 306.f, 306.f)] ;
    circleButton.delegate = self;
    [self.view addSubview:circleButton];
}

- (void)YYCircleButton:(YYCircleButton *)circleButton didSelectedAtIndex:(NSInteger)index
{
    NSLog(@"选中--第%d个--",(int)index);
}

@end
