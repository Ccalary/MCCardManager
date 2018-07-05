//
//  CMTabBarController.m
//  CardManager
//
//  Created by caohouhong on 2018/7/4.
//  Copyright © 2018年 caohouhong. All rights reserved.
//

#import "CMTabBarController.h"
#import "CMNavigationController.h"
#import "CMSearchVC.h"
#import "CMMainViewController.h"
#import "CMMineViewController.h"

@interface CMTabBarController ()

@end

@implementation CMTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITabBar *tabbar = [UITabBar appearance];
    tabbar.tintColor = [UIColor themeColor];
    
    [self addChildViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//添加子控制器
- (void)addChildViewControllers{
    
    [self addChildrenViewController:[[CMSearchVC alloc] init] andTitle:@"Search" andImageName:@"tab_search_n" andSelectImage:@"tab_search_s"];
    [self addChildrenViewController:[[CMMainViewController alloc] init] andTitle:@"Add" andImageName:@"tab_add" andSelectImage:@"tab_add"];
    [self addChildrenViewController:[[CMMineViewController alloc] init] andTitle:@"Setting" andImageName:@"tab_set" andSelectImage:@"tab_set"];
}

- (void)addChildrenViewController:(UIViewController *)childVC andTitle:(NSString *)title andImageName:(NSString *)imageName andSelectImage:(NSString *)selectedImage{
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    childVC.tabBarItem.selectedImage =  [UIImage imageNamed:selectedImage];
    childVC.title = title;
    
    CMNavigationController *baseNav = [[CMNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:baseNav];
}

@end
