//
//  EndlessBannerController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/11.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "EndlessBannerController.h"
#import "EndlessScrollView.h"

#define kFullWidth    [UIScreen mainScreen].bounds.size.width
#define kFullHeight   [UIScreen mainScreen].bounds.size.height
@interface EndlessBannerController ()<EndlessScrollViewDelegate>

@end

@implementation EndlessBannerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"礼物说";
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        NSString *name = [NSString stringWithFormat:@"a%d.JPG",i];
        UIImage *img = [UIImage imageNamed:name];
        [array addObject:img];
    }
    
    EndlessScrollView *bannerView = [[EndlessScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, kFullWidth, kFullWidth) AndImages:array];
    bannerView.delegate = self ;
    [self.view addSubview:bannerView];
}

- (void)endlessScrollview:(EndlessScrollView *)scrollView didSelectedImageAtIndex:(NSInteger)index
{
    NSLog(@"选中******第%d张******图片",(int)index);
}

@end
