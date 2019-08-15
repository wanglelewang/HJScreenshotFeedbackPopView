//
//  HJScreenshotFeedbackPopView.h
//  HJScreenshotFeedbackView
//
//  Created by 2345 on 2019/8/14.
//  Copyright © 2019 wll. All rights reserved.
//  固定大小 CGSizeMake(95, 134)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJScreenshotFeedbackPopView : UIView

/**
 开启监听截屏操作 设置回调
 */
+ (instancetype)registetrObserverWithClickBlk:(void(^)(HJScreenshotFeedbackPopView * view))HJScreenshotFeedbackPopViewClickBlk;

/**
 开启监听截屏操作
 */
+ (instancetype)registetrObserver;


/**
 取消监听截屏操作
 */
+ (void)unRegisterObserver;


/**
 点击回调
 */
@property (nonatomic, copy) void(^HJScreenshotFeedbackPopViewClickBlk)(HJScreenshotFeedbackPopView * popView);



/**
 弹框存在时间 默认5s
 */
@property (nonatomic, assign) NSUInteger timeOut;


/**
 是否开启了监听
 */
@property (nonatomic, assign, readonly) BOOL observerActive;


/**
 frame.origin 默认右侧居中的位置
 */
@property (nonatomic, assign) CGPoint xYPoint;


/**
 获取自身大小
 */
@property (nonatomic, assign, readonly) CGSize sizeSelf;




@end

NS_ASSUME_NONNULL_END
