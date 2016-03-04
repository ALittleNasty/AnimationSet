//
//  UIImage+crop.h
//  AnimationSet
//
//  Created by AiDong on 15/12/1.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (crop)

/**
 *  裁剪图片
 *
 *  @param imageName    图片名称
 *  @param cornerRadius 圆角大小
 *  @param borderWidth  边缘宽度
 *  @param borderColor  边缘颜色
 */
+ (UIImage *)cropImageWithImageName:(NSString *)imageName CornerRadius:(CGFloat)cornerRadius BorderWidth:(CGFloat)borderWidth BorderColor:(UIColor *)borderColor ;

@end
