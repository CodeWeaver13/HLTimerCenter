//
//  HLTimer.h
//  HLTimerCenter
//
//  Created by wangshiyu13 on 2016/9/25.
//  Copyright © 2016年 wangshiyu13. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSNotificationName const HLTimerCancelNotification;

@interface HLTimer : NSObject
@property (nonatomic, assign, readonly)dispatch_time_t startTime;
@property (nonatomic, readonly)dispatch_source_t timer;
@property (nonatomic, assign, readonly)int tCount;
@property (nonatomic, assign, readonly)BOOL isRunning;

/**
 创建HLTimer
 
 - parameter ti:           间隔时间
 - parameter afterTime:    延迟时间
 - parameter repeatsCount: 循环次数
 - parameter repeats:      是否永久循环
 - parameter handler:      回调，默认在主线程
 
 - returns: HLTimer对象
 */
- (instancetype)initWithTime:(NSTimeInterval)ti andAfterTime:(NSTimeInterval)afterTi andRepeatsCount:(int)repeatsCount isRepeats:(BOOL)isRepeats completionHandler:(void (^)())complete;

/**
 暂停Timer
 */
- (void)suspend;

/**
 取消Timer
 */
- (void)cancel;

/**
 启动Timer
 */
- (void)resume;
@end
