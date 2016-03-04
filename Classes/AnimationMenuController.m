//
//  AnimationMenuController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/9.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "AnimationMenuController.h"
#import "YYBottomMenu.h"


#define kFullWidth    [UIScreen mainScreen].bounds.size.width
#define kFullHeight   [UIScreen mainScreen].bounds.size.height

@interface AnimationMenuController ()<YYBottomMenuDelegate>

@end

@implementation AnimationMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"酷炫menu";
    
    YYBottomMenu *menu = [YYBottomMenu bottomMenu] ;
    menu.frame = CGRectMake(0.f, kFullHeight - 45.f, kFullWidth, 45.f) ;
    menu.backgroundColor = [UIColor orangeColor];
    menu.delegate = self ;
    [self.view addSubview:menu];
    
}

#pragma mark - YYBottomMenu delegate method
- (void)YYBottomMenu:(YYBottomMenu *)bottomMenu didSelectedAtIndex:(NSUInteger)index
{
    NSString *text = nil ;
    if (index == 0) {
        text = @"选中---电话---按钮" ;
    }else if (index == 1){
        text = @"选中---联系人---按钮";
    }else if (index == 2){
        text = @"选中---消息---按钮";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:text delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end
