//
//  EndlessScrollView.h
//  AnimationSet
//
//  Created by AiDong on 15/12/11.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EndlessScrollView ;

@protocol EndlessScrollViewDelegate <NSObject>

/**
 *  无线滚动视图的图片点击代理方法
 *
 *  @param scrollView 无线滚动视图
 *  @param index      点击图片的索引
 */
- (void)endlessScrollview:(EndlessScrollView *)scrollView didSelectedImageAtIndex:(NSInteger)index ;

@end

@interface EndlessScrollView : UIView

/**
 *  代理
 */
@property (nonatomic, weak) id<EndlessScrollViewDelegate>delegate ;

/**
 *  快速构建方法
 *
 *  @param frame  大小
 *  @param images 图片数组
 */
- (instancetype)initWithFrame:(CGRect)frame AndImages:(NSArray *)images ;

@end
