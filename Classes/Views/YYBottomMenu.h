//
//  YYBottomMenu.h
//  AnimationSet
//
//  Created by AiDong on 15/12/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

/**
 *  YYBottomMenu 的高度为45.f
 */

#import <UIKit/UIKit.h>
@class YYBottomMenu ;

@protocol YYBottomMenuDelegate <NSObject>

/**
 *  YYBottomMenu 的代理事件方法
 *
 *  @param bottomMenu menu
 *  @param index      点击按钮的索引,从左到右依次为0 , 1 , 2 <不包括红色按钮>
 */
- (void)YYBottomMenu:(YYBottomMenu *)bottomMenu didSelectedAtIndex:(NSUInteger)index ;

@end

@interface YYBottomMenu : UIView

/**
 *  事件代理
 */
@property (nonatomic, weak) id<YYBottomMenuDelegate>delegate ;

/**
 *  快速创建方法
 */
+ (instancetype)bottomMenu ;

@end
