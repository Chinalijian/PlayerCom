//
//  LJRootFrame.m
//  PlayerCom
//
//  Created by Ares on 2017/12/12.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import "LJRootFrame.h"
#import "PCDefine.h"

@implementation LJRootFrame

- (void)initRootVC {

    NSArray *classNameArray = @[@"FirstViewController",
                                @"SecondViewController"];
    NSArray *barTitleArray = @[@"1",@"2"];
    NSArray *titleArray = @[@"1",@"2"];//tabbaritem上的
    NSMutableArray *navigationControllerArray = [[NSMutableArray alloc] init];
    for (int i=0; i<classNameArray.count; i++) {
        UIViewController *viewController = [[NSClassFromString(classNameArray[i]) alloc] init];
        viewController.title = [titleArray objectAtIndex:i];
        viewController.navigationItem.title=[barTitleArray objectAtIndex:i];;
        //viewController.view.tag = i;
        //设置tabbar图片
        UIImage *normalImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_n",i+1]];
        UIImage *selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"tabbar_%d_s", i+1]];
        [viewController.tabBarItem setImageInsets:UIEdgeInsetsMake(-2.0, 0.0, 2.0, 0.0)];//top和bottom相加必须等于0
        viewController.tabBarItem.image = [normalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.tabBarItem.tag = i;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
        [navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
        navigationController.navigationBar.translucent = NO;
        //[navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"NavigationBackground_Image"] resizableImageWithCapInsets:UIEdgeInsetsZero] forBarMetrics:UIBarMetricsDefault];

        [navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x9DC814)];
        [navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0xffffff), NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
        [navigationControllerArray addObject:navigationController];
        
    }

    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       UIColorFromRGB(0x858585), NSForegroundColorAttributeName,
                                                       [UIFont boldSystemFontOfSize:9], NSFontAttributeName,
                                                       nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       UIColorFromRGB(0x9dc814), NSForegroundColorAttributeName,
                                                       [UIFont boldSystemFontOfSize:9], NSFontAttributeName,
                                                       nil] forState:UIControlStateSelected];
    
    _tabBarViewController = [[UITabBarController alloc] init];
    _tabBarViewController.delegate = self;
    _tabBarViewController.tabBar.translucent = NO;
    _tabBarViewController.tabBar.backgroundColor = UIColorFromRGB(0xffffff);
    _tabBarViewController.tabBar.barTintColor = UIColorFromRGB(0xffffff);//背景颜色
    //    _tabBarViewController.tabBar.backgroundImage = [[UIImage imageNamed:@"TabbarBackground_image"] resizableImageWithCapInsets:UIEdgeInsetsZero];
    _tabBarViewController.viewControllers = navigationControllerArray;
    //[self setNavigationTitleForVC:tabBarViewController];

}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSInteger indexs = (unsigned long)self.tabBarViewController.selectedIndex;
    NSLog(@"1111 ========  %ld", (long)indexs);
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    NSInteger indexs = (unsigned long)self.tabBarViewController.selectedIndex;
    NSLog(@"22222 ========  %ld", (long)indexs);
}


@end
