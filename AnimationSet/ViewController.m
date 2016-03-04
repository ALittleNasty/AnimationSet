//
//  ViewController.m
//  AnimationSet
//
//  Created by AiDong on 15/12/1.
//  Copyright © 2015年 AiDong. All rights reserved.
//

#import "ViewController.h"
#import "LayerUsageController.h"
#import "PositionAnchorPointController.h"
#import "CustomLayerUsageController.h"
#import "HidenAnimationController.h"
#import "BasicAnimationController.h"
#import "KeyFrameAnimationController.h"
#import "ShakeAnimationController.h"
#import "TransitionAnimationController.h"
#import "AnimationGroupController.h"
#import "AnimationMenuController.h"
#import "AnimationCircleButtonController.h"
#import "EndlessBannerController.h"

static NSString *cellReuseId = @"homeCellIdentifier";
@interface ViewController ()<UITableViewDataSource,
                             UITableViewDelegate>

@property (weak , nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *viewControllers ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewControllers = @[NSStringFromClass([LayerUsageController class]),
                         NSStringFromClass([PositionAnchorPointController class]),
                         NSStringFromClass([CustomLayerUsageController class]),
                         NSStringFromClass([HidenAnimationController class]),
                         NSStringFromClass([BasicAnimationController class]),
                         NSStringFromClass([KeyFrameAnimationController class]),
                         NSStringFromClass([ShakeAnimationController class]),
                         NSStringFromClass([TransitionAnimationController class]),
                         NSStringFromClass([AnimationGroupController class]),
                         NSStringFromClass([AnimationMenuController class]),
                         NSStringFromClass([AnimationCircleButtonController class]),
                         NSStringFromClass([EndlessBannerController class])];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellReuseId];
}

#pragma mark - tableView datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _viewControllers.count ;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseId forIndexPath:indexPath];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter ;
    cell.textLabel.textColor = [UIColor purpleColor] ;
    cell.textLabel.font = [UIFont systemFontOfSize:18.f] ;
    cell.textLabel.text = _viewControllers[indexPath.row] ;
    
    return cell ;
}

#pragma mark - tableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *className = _viewControllers[indexPath.row] ;
    
    UIViewController *vc = (UIViewController *)[[NSClassFromString(className) alloc] init] ;
    vc.view.backgroundColor = [UIColor whiteColor] ;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
