//
//  LJPlayerControlView.h
//  PlayerCom
//
//  Created by Ares on 2017/12/20.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJPlayerDataModel.h"

typedef NS_ENUM(NSInteger, LJLayerVideoGravityModel) {
    LJLayerVideoGravityModel_Resize,     
    LJLayerVideoGravityModel_Aspect,
    LJLayerVideoGravityModel_AspectFill
};

typedef void (^BlockExitPlay)(void); //

@interface LJPlayerControlView : UIView

@property (nonatomic, strong) BlockExitPlay blockExitPlay;
/**
 *  单例，用于列表cell上多个视频
 *
 *  @return ZFPlayer
 */
+ (instancetype)sharedPlayerView;

- (instancetype)init:(UIView *)rootView exitPlay:(BlockExitPlay)blockExitPlay;
- (void)setPlayerDataUrl:(NSURL *)playerUrl title:(NSString *)videoTitle isAutoPlay:(BOOL)isAuto;
- (void)setPlayerDataModel:(LJPlayerDataModel *)playerData isAutoPlay:(BOOL)isAuto;

/**
 *  自动播放，默认不自动播放
 */
- (void)play;

/**
 *  自动播放，默认不自动播放
 */
- (void)pause;

/**
 *  自动播放，默认不自动播放
 */
- (void)autoPlay;

@end
