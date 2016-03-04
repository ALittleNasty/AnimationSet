//
//  TransitionAnimationController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "TransitionAnimationController.h"


#define kFullWidth    [UIScreen mainScreen].bounds.size.width
#define kFullHeight   [UIScreen mainScreen].bounds.size.height
@interface TransitionAnimationController ()

@property (nonatomic, strong) UIImageView    *imageView ;   // 图片视图
@property (nonatomic, strong) NSMutableArray *imageArray ;  // 存放图片的数组
@property (nonatomic)         int            index ;        // 当前图片的索引
@property (nonatomic, strong) NSArray        *animationTypes; // 动画类型数组

@end

@implementation TransitionAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"转场动画" ;
    _index = 0 ;
    
    _imageArray = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        NSString *name = [NSString stringWithFormat:@"a%d.JPG",i];
        UIImage *img = [UIImage imageNamed:name];
        [_imageArray addObject:img];
    }
    
    _animationTypes = @[@"pageCurl",
                        @"pageUnCurl",
                        @"rippleEffect",
                        @"suckEffect",
                        @"cube",
                        @"oglFlip",
                        @"rotate",
                        @"fade",
                        @"cameraIrisHollowClose",
                        @"cameraIrisHollowOpen"];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.frame = CGRectMake(0.f, ((kFullHeight-kFullWidth)/2), kFullWidth, kFullWidth);
    _imageView.image = [UIImage imageNamed:@"a0.JPG"];
    _imageView.userInteractionEnabled = YES ;
    
    // 添加轻扫手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft ;
    [_imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight ;
    [_imageView addGestureRecognizer:swipeRight];
    
    [self.view addSubview:_imageView];
}

/**
 * 提示:转场的动画的类型（type）和子头型(subtype) 能用字符串常量就用字符常量
 */


/**
 *******************************************************
 type:动画类型(比如：滴水效果，翻转效果...)
 -------------------------------------------------------
 fade kCATransitionFade 交叉淡化过渡
 moveIn kCATransitionMoveIn 新视图移到旧视图上面
 push kCATransitionPush 新视图把旧视图推出去
 reveal kCATransitionReveal 将旧视图移开,显示下面的新视图
 pageCurl               向上翻一页
 pageUnCurl             向下翻一页
 rippleEffect             滴水效果
 suckEffect 收缩效果，如一块布被抽走
 cube                   立方体效果
 oglFlip              上下左右翻转效果
 rotate     旋转效果
 cameraIrisHollowClose 相机镜头关上效果(不支持过渡方向)
 cameraIrisHollowOpen 相机镜头打开效果(不支持过渡方向)
 
 *******************************************************
 subtype: 动画方向(比如说是从左边进入，还是从右边进入...)
 ------------------------------------------------------
 kCATransitionFromRight;
 kCATransitionFromLeft;
 kCATransitionFromTop;
 kCATransitionFromBottom;
 
 当 type 为@"rotate"(旋转)的时候,它也有几个对应的 subtype,分别为:
 90cw 逆时针旋转 90°
 90ccw 顺时针旋转 90°
 180cw 逆时针旋转 180°
 180ccw  顺时针旋转 180°
 **/

#pragma mark - 手势事件处理

- (void)swipeRightAction:(UISwipeGestureRecognizer *)swipeGes
{
    _index -- ;
    if (_index == -1) {
        _index = 9 ;
    }
    
    _imageView.image = _imageArray[_index] ;
    
    // 切换图片的时候 , 使用转场动画
    CATransition *animation = [CATransition animation] ;
    
    // type的类型有: "fade", "moveIn", "push" and "push"
    NSArray *animations = @[@"moveIn",@"push",@"push"] ;
    animation.type = animations[arc4random()%3];
    
    // subType的类型有: "fromLeft", "fromRight", "fromTop" and "fromBottom"
//    animation.subtype = @"fromRight";
    
    animation.duration = 1.0 ;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
}

- (void)swipeLeftAction:(UISwipeGestureRecognizer *)swipeGes
{
    _index ++ ;
    if (_index == 10) {
        _index = 0 ;
    }
    
    _imageView.image = _imageArray[_index] ;
    
    // 切换图片的时候 , 使用转场动画
    CATransition *animation = [CATransition animation] ;
    
    // type的类型有:
    // "fade"    渐变效果
    // "moveIn"  旧的视图不动 , 新的视图移到旧的上面显示出来
    // "push"    推出的效果
    // "reveal"  新的视图不动 , 旧的视图慢慢移走,让新的视图显示出来
    animation.type = _animationTypes[_index];
    
    // subType的类型有:
    // "fromLeft"    从左边开始
    // "fromRight"   从右边开始
    // "fromTop"     从上边开始
    // "fromBottom"  从下边开始
//    animation.subtype = @"fromRight";
    
    animation.duration = 1.0 ;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
}

@end
