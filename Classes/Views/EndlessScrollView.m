//
//  EndlessScrollView.m
//  AnimationSet
//
//  Created by AiDong on 15/12/11.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "EndlessScrollView.h"

#define AutoScrollTimeInterval 3.0
#define kAnimationDuration     1.0
#define kFullWidth             [UIScreen mainScreen].bounds.size.width
#define kFullHeight            [UIScreen mainScreen].bounds.size.height
#define PageControlTintColor   [UIColor colorWithRed:94/255.0 green:196/255.0 blue:249/255.0 alpha:1.0]

@interface EndlessScrollView ()

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray       *imageArray ;

/**
 *  图片指示器
 */
@property (nonatomic, strong) UIPageControl *pageControl ;

/**
 *  图片视图
 */
@property (nonatomic, strong) UIImageView   *imageView ;

/**
 *  当前图片的索引 , 默认是0
 */
@property (nonatomic, assign) NSInteger     currentIndex ;

/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer       *timer ;

@end

@implementation EndlessScrollView

#pragma mark - public method

- (instancetype)initWithFrame:(CGRect)frame AndImages:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageArray = images ;
        _currentIndex = 0 ;
        
        [self initSubviews];
    }
    return self ;
}

#pragma mark - private method

/**
 *  初始化子视图
 */
- (void)initSubviews
{
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    _imageView.image = [UIImage imageNamed:@"a2.JPG"];
    _imageView.userInteractionEnabled = YES ;
    
    // 添加轻扫手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft ;
    [_imageView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight ;
    [_imageView addGestureRecognizer:swipeRight];
    [self addSubview:_imageView];
    
    // 添加单点手势
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [_imageView addGestureRecognizer:tapGes];
    
    NSAssert(0 != _imageArray.count, @"图片数组不能为空...");
    
    CGFloat width = _imageArray.count * 10.f ;
    CGFloat position_x = (kFullWidth - width) / 2 ;
    CGFloat position_y = self.bounds.size.height - 40.f ;
    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.frame = CGRectMake(position_x, position_y, width, 40.f) ;
    _pageControl.numberOfPages = _imageArray.count ;
    _pageControl.currentPage = _currentIndex ;
    _pageControl.tintColor = PageControlTintColor ;
    [self addSubview:_pageControl];
    
    // 延迟2秒后启动自动轮播
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self startTimer];
    });
}

#pragma mark - timer method
/**
 *  开启定时器
 */
- (void)startTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:AutoScrollTimeInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES] ;
}
/**
 *  关闭定时器
 */
- (void)stopTimer
{
    [_timer invalidate];
    _timer = nil ;
}
/**
 *  自动轮播下一张
 */
- (void)nextImage
{
    _currentIndex ++ ;
    if (_currentIndex == _imageArray.count) {
        _currentIndex = 0 ;
    }
    
    _imageView.image = _imageArray[_currentIndex] ;
    
    CATransition *animation = [CATransition animation] ;
    
    animation.type = @"cube";
    
    animation.subtype = kCATransitionFromRight;
    
    animation.duration = kAnimationDuration ;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    _pageControl.currentPage = _currentIndex ;

}

#pragma mark --- 左右滑动事件处理
/**
 *  上一张
 */
- (void)swipeRightAction:(UISwipeGestureRecognizer *)swipeGes
{
    [self stopTimer];
    
    _currentIndex -- ;
    if (_currentIndex == -1) {
        _currentIndex = _imageArray.count - 1 ;
    }
    
    _imageView.image = _imageArray[_currentIndex] ;
    
    CATransition *animation = [CATransition animation] ;
    
    animation.type = @"cube";
    
    animation.subtype = kCATransitionFromLeft;
    
    animation.duration = kAnimationDuration ;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    _pageControl.currentPage = _currentIndex ;
}

/**
 *  下一张
 */
- (void)swipeLeftAction:(UISwipeGestureRecognizer *)swipeGes
{
    [self stopTimer];
    _currentIndex ++ ;
    if (_currentIndex == _imageArray.count) {
        _currentIndex = 0 ;
    }
    
    _imageView.image = _imageArray[_currentIndex] ;
    
    // 切换图片的时候 , 使用转场动画
    CATransition *animation = [CATransition animation] ;

    animation.type = @"cube";

    animation.subtype = kCATransitionFromRight;
    
    animation.duration = kAnimationDuration ;
    
    [self.imageView.layer addAnimation:animation forKey:nil];
    
    _pageControl.currentPage = _currentIndex ;
}
#pragma mark --- 单点图片事件处理
/**
 *  点击图片
 */
- (void)tapGestureAction:(UITapGestureRecognizer *)tap
{
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(endlessScrollview:didSelectedImageAtIndex:)])
    {
        [self.delegate endlessScrollview:self didSelectedImageAtIndex:_currentIndex];
    }
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil ;
    NSLog(@"^^^^^^^^^^^^^^^^^^^^^^^^ %s",__func__);
}

@end
