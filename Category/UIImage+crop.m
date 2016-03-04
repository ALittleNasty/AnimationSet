//
//  UIImage+crop.m
//  AnimationSet
//
//  Created by AiDong on 15/12/1.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "UIImage+crop.h"

@implementation UIImage (crop)

+ (UIImage *)cropImageWithImageName:(NSString *)imageName
                  CornerRadius:(CGFloat)cornerRadius
                   BorderWidth:(CGFloat)borderWidth
                   BorderColor:(UIColor *)borderColor
{
    UIImage *sourceImage = [UIImage imageNamed:imageName];
    // 生成一张新图片
    // 1.开启一个位图上下文
    UIGraphicsBeginImageContextWithOptions(sourceImage.size, NO, 0.0) ;
    
    // 2.把图片画在位图上下文上
    CALayer *layer = [CALayer layer] ;
    // 2.0 设置图层大小
    layer.bounds = CGRectMake(0.f, 0.f, sourceImage.size.width, sourceImage.size.height) ;
    
    // 2.1 设置可以裁剪
    layer.masksToBounds = YES ;
    // 2.2 设置内容
    layer.contents = (id)sourceImage.CGImage ;
    // 2.3 设置圆角
    layer.cornerRadius = cornerRadius ;
    // 2.4 设置边框颜色
    layer.borderColor = borderColor.CGColor ;
    // 2.5 设置边框宽度
    layer.borderWidth = borderWidth ;
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    
    
    // 3.从位图上下文获取新图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext() ;
    
    // 4.结束位图的编辑
    UIGraphicsEndImageContext() ;
    
    // 5.返回新图片
    return newImage ;
}

@end
