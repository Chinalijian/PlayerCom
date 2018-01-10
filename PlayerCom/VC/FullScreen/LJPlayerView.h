//
//  LJPlayerView.h
//  PlayerCom
//
//  Created by Ares on 2017/12/28.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJPlayerView;

@protocol LJPlayerViewDelagate <NSObject>
@optional
/** 返回按钮事件 */
- (void)clickBackAction:(id)sender;
/** 播放按钮事件 */
- (void)clickPlayerAction:(id)sender;
/** 暂停按钮事件 */
- (void)clickPauseAction:(id)sender;
@end

@interface LJPlayerView : UIView
@property (nonatomic, weak) id <LJPlayerViewDelagate> delegate;
@end
