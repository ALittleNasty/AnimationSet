//
//  YYCircleButton.h
//  AnimationSet
//
//  Created by AiDong on 15/12/10.
//  Copyright © 2015年 AiDong. All rights reserved.
//

/**
 *  YYCircleButton 的size为: {306.f, 306.f}
 */

#import <UIKit/UIKit.h>
@class YYCircleButton ;

@protocol YYCircleButtonDelegate <NSObject>

/**
 *  代理事件处理方法
 *
 *  @param circleButton YYCircleButton控件本身
 *  @param index        点击按钮的索引
 */
- (void)YYCircleButton:(YYCircleButton *)circleButton didSelectedAtIndex:(NSInteger)index ;

@end

@interface YYCircleButton : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id <YYCircleButtonDelegate> delegate ;

@end
