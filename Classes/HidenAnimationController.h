//
//  HidenAnimationController.h
//  AnimationSet
//
//  Created by AiDong on 15/12/8.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HidenAnimationController : UIViewController

/*
 "什么是隐式动画，直接改变属性就会有动画效果"
 
 1.根层与非根层,
 *控件的layer属性是根层
 *控件的layer属性的子层就是非根层
 
 2.非根层有隐式动画,根层是没有隐式动画的
 
 3.隐藏动画怎么禁止
 [CATransaction begin];
 [CATransaction setDisableActions:YES];
 //设置隐式动画动画时间
 self.myview.layer.position = CGPointMake(10, 10);
 [CATransaction commit];
 
 */

@end
