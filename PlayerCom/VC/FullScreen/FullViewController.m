//
//  FullViewController.m
//  PlayerCom
//
//  Created by Ares on 2017/12/12.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import "FullViewController.h"
#import "ZFPlayer.h"

#import "LJPlayerControlView.h"

@interface FullViewController ()
<ZFPlayerDelegate>
@property (nonatomic, strong) UIView *playerFatherView;
@property (nonatomic, strong) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (nonatomic, strong) NSURL *videoURL;


@property (nonatomic, strong) LJPlayerControlView *ljPlayerCtrView;


@end

@implementation FullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"全屏播放";
    self.videoURL = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1455782903700jy.mp4"];
//    [self.view addSubview:self.playerView];
//    [self.playerView playerModel:self.playerModel];
//    [self.playerView autoPlayTheVideo];
    [self ljPlay];

}

- (void)ljPlay {
    self.ljPlayerCtrView = [[LJPlayerControlView alloc] init:self.view exitPlay:^{
        
    }];
    [self.ljPlayerCtrView setPlayerDataUrl:self.videoURL title:@"test" isAutoPlay:YES];
    [self.view addSubview:self.ljPlayerCtrView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.videoURL         = self.videoURL;
        _playerModel.fatherView       = self.view;
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        [_playerView playerControlView:nil playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
        
        // 打开下载功能（默认没有这个功能）
        //_playerView.hasDownload    = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
        self.playerView.backgroundColor = [UIColor blackColor];
        
    }
    return _playerView;
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
