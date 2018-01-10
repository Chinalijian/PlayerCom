//
//  LJPlayerControlView.m
//  PlayerCom
//
//  Created by Ares on 2017/12/20.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import "LJPlayerControlView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "LJPlayerView.h"
@interface LJPlayerControlView () <LJPlayerViewDelagate>
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVURLAsset *urlAsset;
@property (nonatomic, strong) AVAssetImageGenerator *imageGenerator;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, strong) NSURL *videoURL;
@property (nonatomic, assign) LJLayerVideoGravityModel layerVideoGravityModel;

/** 滑杆 */
@property (nonatomic, strong) UISlider *volumeViewSlider;

@property (nonatomic, assign) BOOL isAutoPlayer;

@property (nonatomic, strong) LJPlayerDataModel *playerData;

@property (nonatomic, strong) UIView *videoRootView;//用来显示视频的View
@property (nonatomic, strong) LJPlayerView *playerOperationView;

@end

#define STR_IS_NIL(key) (([@"<null>" isEqualToString:(key)] || [@"" isEqualToString:(key)] || key == nil || [key isKindOfClass:[NSNull class]]) ? 1: 0)
#define OBJ_IS_NIL(s) (s==nil || [s isKindOfClass:[NSNull class]])
@implementation LJPlayerControlView

/**
 *  单例，用于列表cell上多个视频
 *
 *  @return ZFPlayer
 */
+ (instancetype)sharedPlayerView {
    static LJPlayerControlView *playerView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        playerView = [[LJPlayerControlView alloc] init];
    });
    return playerView;
}

- (instancetype)init:(UIView *)rootView title:(NSString *)title videoUrl:(NSURL *)videoUrl isAutoPlay:(BOOL)isAutoPlay exitPlay:(BlockExitPlay)blockExitPlay {
    self = [super init];
    if (self) {
        self.videoRootView = rootView;
        self.blockExitPlay = blockExitPlay;
        [self setPlayerDataUrl:videoUrl title:title isAutoPlay:isAutoPlay];
    }
    return self;
}

- (instancetype)init:(UIView *)rootView exitPlay:(BlockExitPlay)blockExitPlay {
    self = [super init];
    if (self) {
        self.videoRootView = rootView;
        self.blockExitPlay = blockExitPlay;
    }
    return self;
}

/**
 *  初始化player
 */
- (void)initializeThePlayerSubViews {
    LJPlayerView *playerOperationView = [[LJPlayerView alloc] init];
    self.playerOperationView = playerOperationView;
}

- (void)configPlayerParam {
    self.urlAsset = [AVURLAsset assetWithURL:self.videoURL];
    
    // 初始化playerItem
    self.playerItem = [AVPlayerItem playerItemWithAsset:self.urlAsset];
    // 每次都重新创建Player，替换replaceCurrentItemWithPlayerItem:，该方法阻塞线程
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    
    // 初始化playerLayer
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    self.backgroundColor = [UIColor blackColor];
    
    // 此处为默认视频填充模式
    [self setLayerVideoGravityModel:LJLayerVideoGravityModel_Aspect];
    
    [self configureVolume];
}

#pragma mark -
#pragma mark - PlayerView delegate event
/** 返回按钮事件 */
- (void)clickBackAction:(id)sender {
    self.blockExitPlay();
}
/** 播放按钮事件 */
- (void)clickPlayerAction:(id)sender {
    
}
/** 暂停按钮事件 */
- (void)clickPauseAction:(id)sender {
    
}

- (void)play {
    [_player play];
}

- (void)pause {
    [_player pause];
}

- (void)autoPlay {
    
    if (OBJ_IS_NIL(self.videoURL)) {
        // 提示视频未知
    } else {
        [self configPlayerParam];
        [self play];
    }
}

- (void)setLayerVideoGravityModel:(LJLayerVideoGravityModel)layerVideoGravity {
    _layerVideoGravityModel = layerVideoGravity;
    switch (layerVideoGravity) {
            case LJLayerVideoGravityModel_Resize:
                self.playerLayer.videoGravity = AVLayerVideoGravityResize;
                break;
            case LJLayerVideoGravityModel_Aspect:
                self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                break;
            case LJLayerVideoGravityModel_AspectFill:
                self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
                break;
            default:
                break;
    }
}

- (void)setPlayerDataUrl:(NSURL *)playerUrl title:(NSString *)videoTitle isAutoPlay:(BOOL)isAuto {
    if (OBJ_IS_NIL(playerUrl)) {
        return;
    }
    if (!_playerData) {
        _playerData = [[LJPlayerDataModel alloc] init];
    }
    _playerData.videoUrl = playerUrl;
    _playerData.videoTitle = videoTitle;
    [self setPlayerDataModel:_playerData isAutoPlay:isAuto];
}

- (void)setPlayerDataModel:(LJPlayerDataModel *)playerData isAutoPlay:(BOOL)isAuto {
    
    [self initializeThePlayerSubViews];
    
    if (!_playerData) {
        _playerData = [[LJPlayerDataModel alloc] init];
    }
    _playerData = playerData;
    self.videoURL = _playerData.videoUrl;
    [self addPlayerToCanvasView:self.videoRootView];
    if (isAuto) {
        [self autoPlay];
    }
}

/**
 *  player添加到画布上
 */
- (void)addPlayerToCanvasView:(UIView *)view {
    if (view) {
        [self removeFromSuperview];
        [view addSubview:self];
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsZero);
        }];
    }
}

/**
 *  获取系统音量
 */
- (void)configureVolume {
    MPVolumeView *volumeView = [[MPVolumeView alloc] init];
    _volumeViewSlider = nil;
    for (UIView *view in [volumeView subviews]){
        if ([view.class.description isEqualToString:@"MPVolumeSlider"]){
            _volumeViewSlider = (UISlider *)view;
            break;
        }
    }
    // 使用这个category的应用不会随着手机静音键打开而静音
    NSError *setCategoryError = nil;
    BOOL success = [[AVAudioSession sharedInstance]
                    setCategory: AVAudioSessionCategoryPlayback
                    error: &setCategoryError];
    if (!success) {
        /* handle the error in setCategoryError */
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
    [self.layer insertSublayer:self.playerLayer atIndex:0];
}

- (void)setPlayerOperationView:(LJPlayerView *)playerOperationView {
    if (_playerOperationView) {
        return;
    }
    _playerOperationView = playerOperationView;
    playerOperationView.delegate = self;
    [self addSubview:playerOperationView];
    [playerOperationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}


@end
