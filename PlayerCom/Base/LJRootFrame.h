//
//  LJRootFrame.h
//  PlayerCom
//
//  Created by Ares on 2017/12/12.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LJRootFrame : NSObject <UINavigationControllerDelegate, UITabBarControllerDelegate>
@property (nonatomic, strong) UITabBarController *tabBarViewController;
- (void)initRootVC;
@end
