//
//  YYBottomMenu.m
//  AnimationSet
//
//  Created by AiDong on 15/12/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "YYBottomMenu.h"


#define AnimationDuration 1.2
#define ItemSpace         90.f

@interface YYBottomMenu ()

/**
 *  红色的主按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *mainMenu;

/**
 *  存放其他三个按钮的数组
 */
@property (nonatomic, strong) NSMutableArray *items ;

@end

@implementation YYBottomMenu

#pragma mark - public method
+ (instancetype)bottomMenu
{
    return [[[NSBundle mainBundle] loadNibNamed:@"YYBottomMenu" owner:nil options:nil] lastObject] ;
}

#pragma mark - private method

#pragma mark --- 对象是从xib/storybard加载的时候，就会调用这个方法
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder ]){
        
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width ;
        self.bounds = CGRectMake(0.f, 0.f, screenWidth, 45.f);
        
        [self initItems];
    }
    
    return self;
}
/**
 *  初始化3个item
 */
- (void)initItems
{
    [self addCustomButtonWithImage:@"menu_call" tag:0];
    [self addCustomButtonWithImage:@"menu_contact" tag:1];
    [self addCustomButtonWithImage:@"menu_message" tag:2];
}

- (void)addCustomButtonWithImage:(NSString *)imageName tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    btn.tag = tag ;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    [self.items addObject:btn];
}

#pragma mark --- 设置三个隐藏按钮的尺寸和位置
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //所有隐藏按钮的大小是一样
    CGRect btnBounds = CGRectMake(0, 0, 43, 43);
    
    //遍历三个隐藏的按钮
    for (UIButton *btn in self.items) {
        btn.bounds = btnBounds;
        btn.center = self.mainMenu.center;
    }
    
    //把 "红色按钮" 置顶
    [self bringSubviewToFront:self.mainMenu];
}

/**
 *  红色的主按钮点击事件
 */
- (IBAction)mainMenuClick:(id)sender
{
    BOOL isShow = CGAffineTransformIsIdentity(self.mainMenu.transform) ;
    
    [UIView animateWithDuration:AnimationDuration animations:^{
       
        if (isShow) { //代表transform未被改变, 改变其transform
            
            self.mainMenu.transform = CGAffineTransformMakeRotation(M_PI_4) ;
        }else{        //代表transform被改变, 恢复为最初的transform
            self.mainMenu.transform = CGAffineTransformIdentity ;
        }
    }];
    
    [self showItemWithShow:isShow];
}
/**
 *  其他三个按钮的点击事件
 */
- (void)buttonClick:(UIButton *)btn
{
    // 先隐藏其他三个按钮
    [self mainMenuClick:self.mainMenu];
    
    // 代理去响应对应的事件
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(YYBottomMenu:didSelectedAtIndex:)])
    {
        [self.delegate YYBottomMenu:self didSelectedAtIndex:btn.tag];
    }
}
/**
 *  显示或者隐藏menu
 */
- (void)showItemWithShow:(BOOL)show
{
    for (UIButton *btn in _items) {
        
        // 重设btn的X
        CGFloat btnCenterX = btn.center.x + ItemSpace*(btn.tag + 1) ;
        CGFloat btnCenterY = btn.center.y ;
        
        CGPoint showPoint = CGPointMake(btnCenterX, btnCenterY) ;
        
        // 给每一个btn添加一个组动画<平移, 旋转>
        CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
        groupAnimation.duration = AnimationDuration ;
        
        NSValue *showValue1 = [NSValue valueWithCGPoint:self.mainMenu.center] ;
        NSValue *showValue2 = [NSValue valueWithCGPoint:CGPointMake((btnCenterX * 0.5) , self.mainMenu.center.y)] ;
        NSValue *showValue3 = [NSValue valueWithCGPoint:CGPointMake((btnCenterX * 1.1) , self.mainMenu.center.y)] ;
        NSValue *showValue4 = [NSValue valueWithCGPoint:showPoint] ;
        
        NSValue *hideValue1 = [NSValue valueWithCGPoint:btn.center] ;
        NSValue *hideValue2 = [NSValue valueWithCGPoint:CGPointMake((btn.center.x * 1.1) , self.mainMenu.center.y)] ;
        NSValue *hideValue3 = [NSValue valueWithCGPoint:CGPointMake((btn.center.x * 0.5) , self.mainMenu.center.y)] ;
        NSValue *hideValue4 = [NSValue valueWithCGPoint:self.mainMenu.center] ;
        
        // 利用帧动画<CAKeyframeAnimation> 创建平移动画
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animation] ;
        positionAnimation.keyPath = @"position";
        
        // 利用帧动画<CAKeyframeAnimation> 创建旋转动画
        CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animation] ;
        rotationAnimation.keyPath = @"transform.rotation";
        
        if (show) { // 显示
            
            positionAnimation.values = @[showValue1, showValue2, showValue3, showValue4];
            rotationAnimation.values = @[@0 , @(M_PI * 2) , @(M_PI * 4) , @(M_PI *2)];
            
            // 改变btn的center
            btn.center = showPoint ;
        }
        else{       // 隐藏
            
            positionAnimation.values = @[hideValue1, hideValue2, hideValue3, hideValue4];
            rotationAnimation.values = @[@0 , @(M_PI * 2) , @0 , @(-M_PI * 2)];
            
            // 改变btn的center
            btn.center = self.mainMenu.center ;
        }
        
        // 将平移动画 , 旋转动画添加到动画数组中
        groupAnimation.animations = @[positionAnimation , rotationAnimation];
        
        // layer 执行动画
        [btn.layer addAnimation:groupAnimation forKey:nil];
    }
}

#pragma mark --- 懒加载 items

- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array] ;
    }
    return _items ;
}
@end
