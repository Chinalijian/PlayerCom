//
//  LJPlayerView.m
//  PlayerCom
//
//  Created by Ares on 2017/12/28.
//  Copyright © 2017年 Jian LI. All rights reserved.
//

#import "LJPlayerView.h"

@interface LJPlayerView ()

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *tLeftButton;
@property (nonatomic, strong) UIButton *tRightButton;

@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) UIButton *bLeftButton;
@property (nonatomic, strong) UILabel *bLeftTimeLabel;
@property (nonatomic, strong) UILabel *bRightTimeLabel;

@end

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((((rgbValue) & 0xFF0000) >> 16))/255.f \
green:((((rgbValue) & 0xFF00) >> 8))/255.f \
blue:(((rgbValue) & 0xFF))/255.f alpha:1.0]

@implementation LJPlayerView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadUI];
        [self setupMakeLayoutSubviews];
    }
    return self;
}

- (void)loadUI {
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    
    [self.topView addSubview:self.tLeftButton];
    
    [self.bottomView addSubview:self.bLeftButton];
    [self.bottomView addSubview:self.bLeftTimeLabel];
    [self.bottomView addSubview:self.progressView];
    [self.bottomView addSubview:self.bRightTimeLabel];
}

- (void)backBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickBackAction:)]) {
        [self.delegate clickBackAction:sender];
    }
}

- (void)playBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickPlayerAction:)]) {
        [self.delegate clickPlayerAction:sender];
    }
}

/** 暂停按钮事件 */
- (void)pauseBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(clickPauseAction:)]) {
        [self.delegate clickPauseAction:sender];
    }
}

#pragma mark -
#pragma mark - LayoutSubviews
- (void)setupMakeLayoutSubviews {
    [self makeTopSubViewsConstraints];
    [self makeBottomSubViewsConstraints];
}

- (void)makeTopSubViewsConstraints {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(64);
    }];
    
    [self.tLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.topView.mas_leading).offset(10);
        make.top.equalTo(self.topView.mas_top).offset(20);
        make.width.height.mas_equalTo(44);
    }];
}

- (void)makeBottomSubViewsConstraints {
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.mas_equalTo(0);
        make.height.mas_equalTo(64);
    }];
    
    [self.bLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bottomView.mas_leading).offset(10);
        make.bottom.equalTo(self.bottomView.mas_bottom).offset(-15);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.bLeftTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bLeftButton.mas_trailing).offset(5);
        make.centerY.equalTo(self.bLeftButton.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    
    [self.bRightTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.bottomView.mas_trailing).offset(-5);
        make.centerY.equalTo(self.bLeftButton.mas_centerY);
        make.width.mas_equalTo(60);
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.bLeftTimeLabel.mas_trailing).offset(4);
        make.trailing.equalTo(self.bRightTimeLabel.mas_leading).offset(-4);
        make.centerY.equalTo(self.bLeftButton.mas_centerY);
    }];
}

#pragma mark -
#pragma mark - UI init
- (UIView *)topView {
    if (!_topView) {
        _topView                        = [[UIView alloc] init];
        _topView.userInteractionEnabled = YES;
        _topView.alpha                  = 0.9;
        _topView.backgroundColor        = UIColorFromRGB(0x212121);
    }
    return _topView;
}

- (UIButton *)tLeftButton {
    if (!_tLeftButton) {
        _tLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tLeftButton setImage:[UIImage imageNamed:@"player_back_icon"] forState:UIControlStateNormal];
        [_tLeftButton setImage:[UIImage imageNamed:@"player_back_icon"] forState:UIControlStateSelected];
        [_tLeftButton addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tLeftButton;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView                        = [[UIView alloc] init];
        _bottomView.userInteractionEnabled = YES;
        _bottomView.alpha                  = 0.9;
        _bottomView.backgroundColor        = UIColorFromRGB(0x212121);
    }
    return _bottomView;
}

- (UIButton *)bLeftButton {
    if (!_bLeftButton) {
        _bLeftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bLeftButton setImage:[UIImage imageNamed:@"video_play_small_icon"] forState:UIControlStateNormal];
        [_bLeftButton setImage:[UIImage imageNamed:@"video_pause_icon"] forState:UIControlStateSelected];
        [_bLeftButton addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bLeftButton;
}

- (UILabel *)bLeftTimeLabel {
    if (!_bLeftTimeLabel) {
        _bLeftTimeLabel               = [[UILabel alloc] init];
        _bLeftTimeLabel.textColor     = [UIColor whiteColor];
        _bLeftTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _bLeftTimeLabel.textAlignment = NSTextAlignmentCenter;
        _bLeftTimeLabel.text          = @"00:00:00";
    }
    return _bLeftTimeLabel;
}

- (UIProgressView *)progressView {
    if (!_progressView) {
        _progressView                   = [[UIProgressView alloc] init];
        _progressView.progressViewStyle = UIProgressViewStyleDefault;
        _progressView.progressTintColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];////设置已过进度部分的颜色
        _progressView.trackTintColor    = [UIColor yellowColor];//设置未过进度部分的颜色
        _progressView.progress          = 0.0f;
    }
    return _progressView;
}
- (UILabel *)bRightTimeLabel {
    if (!_bRightTimeLabel) {
        _bRightTimeLabel               = [[UILabel alloc] init];
        _bRightTimeLabel.textColor     = [UIColor whiteColor];
        _bRightTimeLabel.font          = [UIFont systemFontOfSize:12.0f];
        _bRightTimeLabel.textAlignment = NSTextAlignmentCenter;
        _bRightTimeLabel.text          = @"00:00:00";
    }
    return _bRightTimeLabel;
}
@end
