//
//  HJScreenshotFeedbackPopView.m
//  HJScreenshotFeedbackView
//
//  Created by 2345 on 2019/8/14.
//  Copyright © 2019 wll. All rights reserved.
//

#import "HJScreenshotFeedbackPopView.h"


@interface HJScreenshotFeedbackPopView ()


@property (nonatomic, strong) UIView * topContainerView;

@property (nonatomic, strong) UIImageView *screenshotImageView;

@property (nonatomic, strong) UIView * bottomContainerView;


@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel * tipLabel;

@property (nonatomic, strong) NSTimer * timer;


@end

@implementation HJScreenshotFeedbackPopView

@synthesize xYPoint = _xYPoint;


+ (instancetype)registetrObserverWithClickBlk:(void(^)(HJScreenshotFeedbackPopView * view))HJScreenshotFeedbackPopViewClickBlk {
    [HJScreenshotFeedbackPopView registetrObserver];
    _instance.HJScreenshotFeedbackPopViewClickBlk = HJScreenshotFeedbackPopViewClickBlk;
    return _instance;
}

+ (instancetype)registetrObserver {
    HJScreenshotFeedbackPopView * objc = [HJScreenshotFeedbackPopView instance];
    if (!objc.observerActive) {
        [[NSNotificationCenter defaultCenter] addObserver:objc selector:@selector(userDidTakeScreenshot:) name:UIApplicationUserDidTakeScreenshotNotification object:nil];
        objc->_observerActive = YES;
    }
    return _instance;
}


/**
 取消监听截屏操作
 */
+ (void)unRegisterObserver {
    HJScreenshotFeedbackPopView * objc = [HJScreenshotFeedbackPopView instance];
    if (objc.observerActive) {
        [[NSNotificationCenter defaultCenter] removeObserver:objc name:UIApplicationUserDidTakeScreenshotNotification object:nil];
        objc->_observerActive = NO;
    }
    
}

- (void)tapClick {
    if (self.HJScreenshotFeedbackPopViewClickBlk) {
        self.HJScreenshotFeedbackPopViewClickBlk(self);
    }
    [self removePopView];
}

- (void)setXYPoint:(CGPoint)xYPoint {
    _xYPoint = xYPoint;
    CGRect frame = self.frame;
    frame.origin = xYPoint;
    self.frame = frame;
}

- (CGPoint)xYPoint {
    return _xYPoint;
}

static HJScreenshotFeedbackPopView * _instance;

+ (instancetype)instance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[HJScreenshotFeedbackPopView alloc] init];

    });
    return _instance;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}



- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self createUI];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (!newSuperview) {
        if (_timer) {
            [_timer invalidate];
        }
    }
}

- (void)createUI {
    self.timeOut = 5;
    //FIXME:自身弹框大小 调整完记得要去layoutSubView中调整子视图的frame
    _sizeSelf = CGSizeMake(95, 134);
    _observerActive = NO;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 100;
    CGFloat y = ([UIScreen mainScreen].bounds.size.height - 134)/2.0;
    _xYPoint = CGPointMake(x, y);
    
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    
    [self addSubview:self.topContainerView];
    [self.topContainerView addSubview:self.screenshotImageView];
    
    [self addSubview:self.bottomContainerView];
    [self.bottomContainerView addSubview:self.iconImageView];
    [self.bottomContainerView addSubview:self.tipLabel];
    [self layoutIfNeeded];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self addGestureRecognizer:tap];
    
}

- (void)layoutSubviews {
    
    
    self.frame = CGRectMake(self.xYPoint.x, self.xYPoint.y, self.sizeSelf.width, self.sizeSelf.height);
    
    self.topContainerView.frame = CGRectMake(0, 0, self.sizeSelf.width, 95);
    
    self.screenshotImageView.frame = CGRectMake(6, 6, 83, 83);
    
    self.bottomContainerView.frame = CGRectMake(0, 101, self.sizeSelf.width, 33);
    
    self.iconImageView.frame = CGRectMake(8, 7.5, 18, 18);
    
    self.tipLabel.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame), 0, CGRectGetWidth(self.bottomContainerView.frame) - CGRectGetMaxX(self.iconImageView.frame), CGRectGetHeight(self.bottomContainerView.frame));
    
    
}


////截屏通知
- (void)userDidTakeScreenshot:(NSNotification *)noti {
    
    for (UIWindow * window in [UIApplication sharedApplication].windows) {
        if ([window respondsToSelector:@selector(snapshotViewAfterScreenUpdates:)]) {
            
            UIView * snapshot = [window snapshotViewAfterScreenUpdates:NO];
            snapshot.frame = self.screenshotImageView.bounds;
            [self.screenshotImageView addSubview:snapshot];
            [window addSubview:self];
            [self fireTimer];
            break;
        }
    }
    
    
}


- (void)fireTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [self timer];
    
}

- (void)removePopView {
    
    [self removeFromSuperview];
    
}


/////get

- (UIView *)topContainerView {
    if (!_topContainerView) {
        _topContainerView = [[UIView alloc] init];
        _topContainerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.62];
        _topContainerView.layer.cornerRadius = 5.5;
    }
    return _topContainerView;
}


- (UIImageView *)screenshotImageView {
    if (!_screenshotImageView) {
        _screenshotImageView = [UIImageView new];
    }
    return _screenshotImageView;
}

- (UIView *)bottomContainerView {
    if (!_bottomContainerView) {
        _bottomContainerView = [[UIView alloc] init];
        _bottomContainerView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.62];
        _bottomContainerView.layer.cornerRadius = 6;
    }
    return _bottomContainerView;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        NSBundle * bundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[HJScreenshotFeedbackPopView class]] pathForResource:@"HJScreenshot" ofType:@"bundle"]];
        _iconImageView.image = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"home_icon_complain@2x" ofType:@"png"]];
    }
    return _iconImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.text = @"我要投诉";
        _tipLabel.font = [UIFont systemFontOfSize:13];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:self.timeOut target:self selector:@selector(removePopView) userInfo:nil repeats:NO];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
