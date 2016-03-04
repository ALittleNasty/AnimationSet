//
//  LayerUsageController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/1.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "LayerUsageController.h"
#import "UIImage+crop.h"

@interface LayerUsageController ()

@property (nonatomic, strong) UIImageView *imgView ;

@end

@implementation LayerUsageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图层的基本使用";
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 150, 150)];
    _imgView.image = [UIImage imageNamed:@"01.jpg"];
    [self.view addSubview:_imgView];
    
//    [self layerBasicUse];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self layer_transform3D_use];
}

/**
 *  layer的形变属性使用
 */
- (void)layer_transform3D_use
{
    // 缩放
//    self.imgView.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5);
    
    // 旋转
    // (1, 0, 0) 绕X轴旋转
    // (0, 1, 0) 绕Y轴旋转
    // (0, 0, 1) 绕Z轴旋转
//    self.imgView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1) ;
    
    // 平移
//    self.imgView.layer.transform = CATransform3DMakeTranslation(10.f, 10.f, 0.f);
    
    // 使用KVC的方法 改变 属性值
//    [self.imgView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeScale(2.0, 2.0, 1.0)] forKey:@"transform"];
    
    //*********************** transform 里面有更具体形变属性 <使用: setValue forKeyPath:> ***************************//
    
    // 缩放 <z轴的缩放我们是看不到的 , 因为Z轴的方向是垂直于手机屏幕>
    //transform.scale.x 代表x方向上缩放
    //transform.scale.y 代表y方向上缩放
//    [self.imgView.layer setValue:@(1.5) forKeyPath:@"transform.scale.y"];
    
    // 旋转
    //transform.rotation.z z轴旋转
    //transform.rotation.x x轴旋转
    //transform.rotation.y y轴旋转
//    [self.imgView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation.y"];
    
    // 平移
    //transfrom.translation.x x方向移动
    //transfrom.translation.y y方向移动
//    [self.imgView.layer setValue:@(-20) forKeyPath:@"transform.translation.x"];
    //不具体指定x还是y方向的移动
    // x > 0 && y > 0 往右下方向移动
    // x > 0 && y < 0 往右上方向移动
    // x < 0 && y > 0 往左下方向移动
    // x < 0 && y < 0 往左上方向移动
//    [self.imgView.layer setValue:[NSValue valueWithCGPoint:CGPointMake(20, 20)] forKeyPath:@"transform.translation"];
    
#warning kvc设置不仅限于transform属性，只要layer有的属性，都设置
    [self.imgView.layer setValue:[NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)] forKey:@"bounds"];
}

/**
 *  图层Layer的基本使用
 */
- (void)layerBasicUse
{
    _imgView.layer.shadowColor = [UIColor greenColor].CGColor;
    _imgView.layer.shadowOffset = CGSizeMake(50.f, 50.f);
    _imgView.layer.shadowOpacity = 0.5 ;
    
    
    UIImage *cropImg = [UIImage cropImageWithImageName:@"01.jpg" CornerRadius:50.f BorderWidth:2.f BorderColor:[UIColor purpleColor]];
    _imgView.layer.contents = (id)cropImg.CGImage ;
}

@end
