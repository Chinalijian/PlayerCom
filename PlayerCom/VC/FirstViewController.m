//
//  FirstViewController.m
//  PlayerCom
//
//  Created by Ares on 2017/12/12.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import "FirstViewController.h"

#import "FullViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *smallScr = [UIButton buttonWithType:UIButtonTypeCustom];
    smallScr.frame = CGRectMake(20, (self.view.frame.size.height/2) - 64-49-100, self.view.frame.size.width-40, 100);
    [smallScr setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [smallScr setTitle:@"小屏播放" forState:UIControlStateNormal];
    [smallScr addTarget:self action:@selector(clickSmallScreenPlay) forControlEvents:UIControlEventTouchUpInside];
    smallScr.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:smallScr];
    
    UIButton *fullScr = [UIButton buttonWithType:UIButtonTypeCustom];
    fullScr.frame = CGRectMake(20, self.view.frame.size.height/2+50 -64-49, self.view.frame.size.width-40, 100);
    [fullScr setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [fullScr setTitle:@"全屏播放" forState:UIControlStateNormal];
    [fullScr addTarget:self action:@selector(clickFullScreenPlay) forControlEvents:UIControlEventTouchUpInside];
    fullScr.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:fullScr];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)clickSmallScreenPlay {
    
}

- (void)clickFullScreenPlay {
    FullViewController *fullVC = [[FullViewController alloc] init];
    fullVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fullVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
