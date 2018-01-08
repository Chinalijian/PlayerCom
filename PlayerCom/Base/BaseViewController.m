//
//  BaseViewController.m
//  PlayerCom
//
//  Created by Ares on 2017/12/12.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import "BaseViewController.h"
#import "PCDefine.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    //坐标系统从导航下开始计算
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self setupBackButton];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}

- (void)setupBackButton {
    
    if (self.navigationController != nil) {
        
        if (self.navigationController.viewControllers.count > 1) {
            
            UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            backButton.frame = CGRectMake(0, 0, 44, 44);
            backButton.backgroundColor = [UIColor clearColor];
            ////////
            [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0xffffff)];
            [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x515151), NSFontAttributeName:[UIFont boldSystemFontOfSize:18]}];
            [backButton setImage:[UIImage imageNamed:@"fanhui_hui"] forState:UIControlStateNormal];
            [backButton setImage:[UIImage imageNamed:@"fanhui_hui"] forState:UIControlStateHighlighted];
            [backButton setImage:[UIImage imageNamed:@"fanhui_hui"] forState:UIControlStateSelected];

            [backButton setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0, 0.0, 10.0)];
            backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 14);//ios7以下 －5和5
            [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
            UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
            
            fixedSpace.width = 0;
            
            self.navigationItem.leftBarButtonItems = @[fixedSpace,[[UIBarButtonItem alloc] initWithCustomView:backButton]];
        }
    }
}
- (void)backAction:(id)sender {
    
    if ([self.navigationController.viewControllers count]>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
