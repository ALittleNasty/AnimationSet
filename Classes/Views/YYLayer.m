//
//  YYLayer.m
//  AnimationSet
//
//  Created by AiDong on 15/12/8.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "YYLayer.h"

@implementation YYLayer

- (void)drawInContext:(CGContextRef)ctx
{
    CGContextFillEllipseInRect(ctx, CGRectMake(0.f, 0.f, 100.f, 100.f)) ;
}

@end
